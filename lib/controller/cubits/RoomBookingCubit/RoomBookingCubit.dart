import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/RoomBookingCubit/RoomBookingState.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';

class RoomBookingCubit extends Cubit<RoomBookingState> {
  RoomBookingCubit() : super(RoomBookingInitial());


  Future<void> bookingRoom({required String checkIn,required String checkOut,required String paymentWay,required int roomId}) async {
    emit(RoomBookingLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int ;
    try {

      final response = await http.post(Uri.parse('${Globals().ngrok}/api/user/hotel/room/$roomId/book'),
        body: jsonEncode({
          'check_in': checkIn,
          'check_out': checkOut,
          'payment_method': paymentWay,
        }),
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

        final message = jsonDecode(response.body)['message'];

        emit(RoomBookingSuccess(message: message));

      }else if(response.statusCode==422){
        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(RoomBookingFailure(message: message));
      }else if(response.statusCode== 409){
        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(RoomBookingFailure(message: message));
      }else if(response.statusCode==404){
        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(RoomBookingFailure(message: message));
      }
      else {
        emit( RoomBookingFailure(message: 'Please Try Again') );
      }
    } catch (e) {
      emit(RoomBookingFailure(message: e.toString()));
    }
  }




  @override
  void onChange(Change<RoomBookingState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }

}

