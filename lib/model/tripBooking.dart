class TripBooking {
  final int id;
  final int userId;
  final int tripId;
  final int tripStopId;
  final int tripStopSeatId;
  final int roomId;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final int numberOfTickets;
  final int totalPrice;
  final int rating;
  final String bookingCode;
  final String createdAt;
  final String updatedAt;

  TripBooking({
    required this.id,
    required this.userId,
    required this.tripId,
    required this.tripStopId,
    required this.tripStopSeatId,
    required this.roomId,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.numberOfTickets,
    required this.totalPrice,
    required this.rating,
    required this.bookingCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripBooking.fromJson(Map<String, dynamic> json) {
    return TripBooking(
      id: json['id'],
      userId: json['user_id'],
      tripId: json['trip_id'],
      tripStopId: json['trip_stop_id'],
      tripStopSeatId: json['trip_stop_seat_id'],
      roomId: json['room_id'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      numberOfTickets: json['number_of_tickets'],
      totalPrice: json['total_price'],
      rating: json['rating'],
      bookingCode: json['booking_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'trip_id': tripId,
      'trip_stop_id': tripStopId,
      'trip_stop_seat_id': tripStopSeatId,
      'room_id': roomId,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'number_of_tickets': numberOfTickets,
      'total_price': totalPrice,
      'rating': rating,
      'booking_code': bookingCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
