import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/model/destination.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import 'destinationState.dart';


class DestinationsCubit extends Cubit<DestinationsState> {
  DestinationsCubit() : super(DestinationsInitial());

  List<Destination> destinationsList = [];
  bool isDestinationFavoriteUpdating = false;

  Future<void> getDestinations() async {
    emit(DestinationsLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int ;
    try {

      final response = await http.get(Uri.parse('${Globals().ngrok}/api/user/get/destinations/$cityId'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(token);
      print(cityId);

      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);



        destinationsList.clear();

        if (jsonResponse['destinations'] != null &&
            jsonResponse['destinations'] is List) {
          (jsonResponse['destinations'] as List).forEach((v) {
            destinationsList.add(Destination.fromJson(v));
          });
        }

        print(destinationsList);
        print(destinationsList.length);


        emit(DestinationsSuccess(
          destinations: destinationsList,
        ));

      } else {
        emit( DestinationsFailure(error: 'Failed To Load Data') );
      }
    } catch (e) {
      emit(DestinationsFailure(error: e.toString()));
    }
  }


  Future<Map<String, dynamic>> toggleDestinationFavorite(Destination destination) async {
    if (isDestinationFavoriteUpdating || state is! DestinationsSuccess) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'destination': destination,
      };
    }
    isDestinationFavoriteUpdating = true;

    final oldIsFav = destination.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as DestinationsSuccess;

    final updatedList = s.destinations.map((d) {
      return d.destinationId == destination.destinationId ? d.copyWith(isFavorite: newIsFav) : d;
    }).toList();
    emit(s.copyWith(destinations: updatedList));

    final resp = await _updateDestinationFavoriteOnServer(destination.destinationId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (!success) {
      final revertedList = updatedList.map((d) {
        return d.destinationId == destination.destinationId ? d.copyWith(isFavorite: oldIsFav) : d;
      }).toList();
      emit(s.copyWith(destinations: revertedList));
    }

    isDestinationFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'destination': success ? destination.copyWith(isFavorite: newIsFav) : destination,
    };
  }

  Future<Map<String, dynamic>> _updateDestinationFavoriteOnServer(
      int destinationId, bool isFavorite) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': destinationId,
          'favoritable_type': 'City',
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Updated successfully'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Update failed'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.'
      };
    }
  }





  @override
  void onChange(Change<DestinationsState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }

}

