import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/roomCubit/roomState.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/room.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsCubit() : super(RoomsInitial());

  Future<void> getRooms({required int hotelId}) async {
    emit(RoomsLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int;
    try {
      final response = await http.get(Uri.parse('${Globals().ngrok}/api/user/hotel/$hotelId/rooms/show'),
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

        List<Room> roomsList = [];

        print(roomsList);


        if (jsonResponse['rooms'] != null &&
            jsonResponse['rooms'] is List) {
          (jsonResponse['rooms'] as List).forEach((v) {
            roomsList.add(Room.fromJson(v));
          });
        }

        emit(RoomsSuccess(
          rooms: roomsList,
        ));

      } else {
        emit( RoomsFailure(error: 'Failed To Load Data') );
      }
    } catch (e) {
      emit(RoomsFailure(error: e.toString()));
    }
  }



  @override
  void onChange(Change<RoomsState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }

}

