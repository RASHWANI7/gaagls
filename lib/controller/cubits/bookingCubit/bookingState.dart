import 'package:gaagls/model/bookingType.dart';

abstract class BookingsState {}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  final List<BookingItem> bookings;
  BookingsLoaded(this.bookings);
}

class BookingsError extends BookingsState {
  final String message;
  BookingsError(this.message);
}
