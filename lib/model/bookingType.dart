enum BookingType { room, carRental, flight, trip, restaurant }

class BookingItem {
  final BookingType type;
  final dynamic booking;

  BookingItem({
    required this.type,
    required this.booking,
  });
}
