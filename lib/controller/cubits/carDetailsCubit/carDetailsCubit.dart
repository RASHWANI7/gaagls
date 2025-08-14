import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/globals/globals.dart';

import 'carDetailsState.dart';
import 'package:http/http.dart' as http;


enum SlideDirection { left, right }

class CarDetailsCubit extends Cubit<CarDetailsState> {
  final int carsLength;
  SlideDirection? slideDirection;

  CarDetailsCubit({required int initialIndex, required this.carsLength})
      : super(CarDetailsState(
    currentIndex: initialIndex,
    favorites: {},
    ratings: {},
    isBooked: {for (var i = 0; i < carsLength; i++) i: false},
    startDates: {for (var i = 0; i < carsLength; i++) i: null},
    endDates: {for (var i = 0; i < carsLength; i++) i: null},
    isNext: true,
  ));

  void toggleFavorite(int index) {
    final newFavorites = Set<int>.from(state.favorites);
    if (newFavorites.contains(index)) {
      newFavorites.remove(index);
    } else {
      newFavorites.add(index);
    }
    emit(state.copyWith(favorites: newFavorites));
  }

  void setRating(int index, int rating) {
    final newRatings = Map<int, int>.from(state.ratings)..[index] = rating;
    emit(state.copyWith(ratings: newRatings));
  }

  void setStartDate(int carIndex, DateTime date) {
    final newStartDates = Map<int, DateTime?>.from(state.startDates);
    final newEndDates = Map<int, DateTime?>.from(state.endDates);

    if (newEndDates[carIndex] != null && newEndDates[carIndex]!.isBefore(date)) {
      newEndDates[carIndex] = null;
    }

    newStartDates[carIndex] = date;

    emit(state.copyWith(startDates: newStartDates, endDates: newEndDates));
  }

  void setEndDate(int carIndex, DateTime date) {
    final newEndDates = Map<int, DateTime?>.from(state.endDates);
    newEndDates[carIndex] = date;

    emit(state.copyWith(endDates: newEndDates));
  }

  void changeIndex(int newIndex, bool forward) {
    if (newIndex < 0 || newIndex >= carsLength) return;

    slideDirection = forward ? SlideDirection.left : SlideDirection.right;

    emit(state.copyWith(currentIndex: newIndex, isNext: forward));
  }

  void clearSlideDirection() {
    slideDirection = null;
  }


  void resetBookingState() {
    emit(state.copyWith(successBook: false, failureBook: false));
  }


  // Future<void> confirmBooking({
  //   required int carId,
  //   required String startDate,
  //   required String endDate,
  //   required String paymentMethod,
  // }) async {
  //   final updatedBookings = Map<int, bool>.from(state.isBooked);
  //   updatedBookings[state.currentIndex] = true;
  //
  //   emit(state.copyWith(isBooked: updatedBookings,isLoading: true));
  //
  //   final  token = await Globals().getToken() as String;
  //
  //   final url = Uri.parse('${Globals().ngrok}/api/user/car/$carId/book');
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Authorization' : 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       'start': startDate,
  //       'end': endDate,
  //       'payment_method' :paymentMethod
  //     }),
  //   );
  //
  //   print(startDate);
  //   print(endDate);
  //   print(paymentMethod);
  //
  //   final responseBody = jsonDecode(response.body);
  //   print(responseBody);
  //   print(response.statusCode);
  //
  //   if(response.statusCode==200){
  //     final message = jsonDecode(response.body)['message'];
  //     print(message);
  //     emit(state.copyWith(successBook: true ,isLoading: false,bookingMessage: message,isBooked: updatedBookings,));
  //   }else if(response.statusCode==422){
  //     final message = jsonDecode(response.body)['message'];
  //     print(message);
  //     emit(state.copyWith(failureBook: true,isLoading: false,bookingMessage: message));
  //   }else if(response.statusCode==409){
  //     final message = jsonDecode(response.body)['message'];
  //     print(message);
  //     emit(state.copyWith(failureBook: true,isLoading: false,bookingMessage: message));
  //   }else if(response.statusCode==404){
  //     final message = jsonDecode(response.body)['message'];
  //     print(message);
  //     emit(state.copyWith(failureBook: true,isLoading: false,bookingMessage: message));
  //   }
  //   else{
  //     emit(state.copyWith(failureBook:true,isLoading: false));
  //   }
  //
  //
  // }



  Future<void> confirmBooking({
    required int carId,
    required String startDate,
    required String endDate,
    required String paymentMethod,
  }) async {

    emit(state.copyWith( isLoading: true));

    try {
      final token = await Globals().getToken() as String;
      final url = Uri.parse('${Globals().ngrok}/api/user/car/$carId/book');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'start': startDate,
          'end': endDate,
          'payment_method': paymentMethod,
        }),
      );

      print(startDate);
      print(endDate);
      print(paymentMethod);

      final responseBody = jsonDecode(response.body);
      print(responseBody);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final message = responseBody['message'];
        print(message);
        final updatedBookings = Map<int, bool>.from(state.isBooked);
        updatedBookings[state.currentIndex] = true;
        emit(state.copyWith(
          successBook: true,
          isLoading: false,
          bookingMessage: message,
          isBooked: updatedBookings,
        ));
      } else if (response.statusCode == 422 ||
          response.statusCode == 409 ||
          response.statusCode == 404) {
        final message = responseBody['message'];
        print(message);
        emit(state.copyWith(
          failureBook: true,
          isLoading: false,
          bookingMessage: message,
        ));
      } else {
        emit(state.copyWith(failureBook: true, isLoading: false));
      }
    } catch (e) {
      print("Booking error: $e");

      emit(state.copyWith(
        failureBook: true,
        isLoading: false,
        bookingMessage: "Something went wrong. Please try again.",
      ));
    }
  }




}