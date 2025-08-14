import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/EditBookingCubit/editBookingState.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';

class Editbookingcubit extends Cubit<Editbookingstate> {
  Editbookingcubit() : super(EditbookingInitial());

  Future<void> rateBooking({required String type,required int id,required int rating}) async {
    emit(EditbookingLoading());

    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;

    try {
      final response = await http.post(Uri.parse(
          '${Globals().ngrok}/api/user/rate'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rateable_type': type,
          'rateable_id': id,
          'rating': rating,
        }),
      );

      print(type);
      print(id);
      print(rating);

      print(response.statusCode);

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {

        print(data['message']);

        emit(EditbookingLoaded(message: data['message']));
      } else {
        print(data['message']);
        emit(EditbookingError(message: data['message']));
      }
    } catch (e) {
      emit(EditbookingError(message: 'حدث خطأ أثناء التحميل: $e'));
    }
  }



  Future<void> cancelBooking({required String type,required int id}) async {
    emit(EditbookingLoading());

    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;

    try {
      final response = await http.post(Uri.parse(
          '${Globals().ngrok}/api/user/cancel/booked_service'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'type': type,
          'book_id': id,
        }),
      );

      print(type);
      print(id);

      print(response.statusCode);

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {

        print(data['message']);

        emit(EditbookingLoaded(message: data['message']));
      } else {
        print(data['message']);
        emit(EditbookingError(message: data['message']));
      }
    } catch (e) {
      emit(EditbookingError(message: 'حدث خطأ أثناء التحميل: $e'));
    }
  }

}
