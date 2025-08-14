import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/bookingType.dart';
import '../../../model/carRentalBooking.dart';
import '../../../model/flightBooking.dart';
import '../../../model/restaurantBooking.dart';
import '../../../model/roomBooking.dart';
import '../../../model/tripBooking.dart';
import 'bookingState.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit() : super(BookingsInitial());

  // Future<void> loadBookings() async {
  //   emit(BookingsLoading());
  //
  //   final token = await Globals().getToken();
  //   if (token == null) {
  //     emit(BookingsError('رمز المصادقة مفقود'));
  //     return;
  //   }
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${Globals().ngrok}/api/user/get/booked_service'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print(response.statusCode);
  //     print(response.body);
  //
  //     if (response.statusCode == 200) {
  //       List<dynamic> data;
  //       try {
  //         data = json.decode(response.body);
  //       } catch (e) {
  //         emit(BookingsError('خطأ في تحليل البيانات المستلمة: $e'));
  //         return;
  //       }
  //
  //       final bookings = <BookingItem>[];
  //
  //       for (var bookingMap in data) {
  //         if (bookingMap.containsKey('room_booking')) {
  //           bookings.add(BookingItem(
  //             type: BookingType.room,
  //             booking: RoomBooking.fromJson(bookingMap['room_booking']),
  //           ));
  //         } else if (bookingMap.containsKey('car_rental')) {
  //           bookings.add(BookingItem(
  //             type: BookingType.carRental,
  //             booking: CarRentalBooking.fromJson(bookingMap['car_rental']),
  //           ));
  //         } else if (bookingMap.containsKey('flight_booking')) {
  //           bookings.add(BookingItem(
  //             type: BookingType.flight,
  //             booking: FlightBooking.fromJson(bookingMap['flight_booking']),
  //           ));
  //         } else if (bookingMap.containsKey('trip_booking')) {
  //           bookings.add(BookingItem(
  //             type: BookingType.trip,
  //             booking: TripBooking.fromJson(bookingMap['trip_booking']),
  //           ));
  //         } else if (bookingMap.containsKey('restaurant_booking')) {
  //           bookings.add(BookingItem(
  //             type: BookingType.restaurant,
  //             booking: RestaurantBooking.fromJson(bookingMap['restaurant_booking']),
  //           ));
  //         } else {
  //           print('Unknown booking format: $bookingMap');
  //         }
  //       }
  //       print(bookings);
  //
  //       emit(BookingsLoaded(bookings));
  //     } else {
  //       emit(BookingsError('فشل في جلب البيانات: ${response.statusCode}'));
  //     }
  //   } catch (e) {
  //     emit(BookingsError('حدث خطأ أثناء التحميل: $e'));
  //   }
  // }



Future<void> loadBookings() async {
    emit(BookingsLoading());

    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;

    try {
      final response = await http.get(Uri.parse(
          '${Globals().ngrok}/api/user/get/booked_service'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        final bookings = <BookingItem>[];

        for (var bookingMap in data) {
          if (bookingMap.containsKey('room_booking')) {
            var room = RoomBooking.fromJson(bookingMap['room_booking']);
            bookings.add(BookingItem(type: BookingType.room, booking: room));
          } else if (bookingMap.containsKey('car_rental')) {
            var car = CarRentalBooking.fromJson(bookingMap['car_rental']);
            bookings.add(BookingItem(type: BookingType.carRental, booking: car));
          } else if (bookingMap.containsKey('flight_booking')) {
            var flight = FlightBooking.fromJson(bookingMap['flight_booking']);
            bookings.add(BookingItem(type: BookingType.flight, booking: flight));
          } else if (bookingMap.containsKey('trip_booking')) {
            var trip = TripBooking.fromJson(bookingMap['trip_booking']);
            bookings.add(BookingItem(type: BookingType.trip, booking: trip));
          } else if (bookingMap.containsKey('restaurant_booking')) {
            var restaurant = RestaurantBooking.fromJson(bookingMap['restaurant_booking']);
            bookings.add(BookingItem(type: BookingType.restaurant, booking: restaurant));
          }
        }

        print(bookings);

        emit(BookingsLoaded(bookings));
      } else {
        emit(BookingsError('فشل في جلب البيانات: ${response.statusCode}'));
      }
    } catch (e) {
      emit(BookingsError('حدث خطأ أثناء التحميل: $e'));
    }
  }

}
