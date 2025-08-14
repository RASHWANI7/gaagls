import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/model/airline.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/trip.dart';
import 'airlineState.dart';

class AirLinesCubit extends Cubit<AirLinesState> {
  AirLinesCubit() : super(AirLinesInitial());

  Future<void> getAirLines({required int destinationId}) async {
    emit(AirLinesLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int ;
    try {

      final response = await http.get(Uri.parse('${Globals().ngrok}/api/user/get/available/airlines/to/destination/$cityId/$destinationId'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(token);
      print(cityId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        List<Airline> airlinesList = [];

        print(airlinesList);


        if (jsonResponse['airlines'] != null &&
            jsonResponse['airlines'] is List) {
          (jsonResponse['airlines'] as List).forEach((v) {
            airlinesList.add(Airline.fromJson(v));
          });
        }

        emit(AirLinesSuccess(
          airlines: airlinesList,
        ));

      } else {
        emit( AirLinesFailure(error: 'Failed To Load Data') );
      }
    } catch (e) {
      emit(AirLinesFailure(error: e.toString()));
    }
  }




  @override
  void onChange(Change<AirLinesState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }

}

