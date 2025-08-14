class FlightBooking {
  final int id;
  final int userId;
  final int flightId;
  final int flightSeatId;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final int numberOfTickets;
  final int rating;
  final int totalPrice;
  final String? cancelReason;
  final String bookingCode;
  final String createdAt;
  final String updatedAt;

  FlightBooking({
    required this.id,
    required this.userId,
    required this.flightId,
    required this.flightSeatId,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.numberOfTickets,
    required this.rating,
    required this.totalPrice,
    this.cancelReason,
    required this.bookingCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FlightBooking.fromJson(Map<String, dynamic> json) {
    return FlightBooking(
      id: json['id'],
      userId: json['user_id'],
      flightId: json['flight_id'],
      flightSeatId: json['flight_seat_id'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      numberOfTickets: json['number_of_tickets'],
      rating: json['rating'],
      totalPrice: json['total_price'],
      cancelReason: json['cancel_reason'],
      bookingCode: json['booking_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'flight_id': flightId,
      'flight_seat_id': flightSeatId,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'number_of_tickets': numberOfTickets,
      'rating': rating,
      'total_price': totalPrice,
      'cancel_reason': cancelReason,
      'booking_code': bookingCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
