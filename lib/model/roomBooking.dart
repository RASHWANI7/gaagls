class RoomBooking {
  final int id;
  final int userId;
  final int roomId;
  final int? tripId;
  final String checkIn;
  final String checkOut;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final int rating;
  final int totalPrice;
  final String? cancelReason;
  final String bookingCode;
  final String createdAt;
  final String updatedAt;

  RoomBooking({
    required this.id,
    required this.userId,
    required this.roomId,
    this.tripId,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.rating,
    required this.totalPrice,
    this.cancelReason,
    required this.bookingCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomBooking.fromJson(Map<String, dynamic> json) {
    return RoomBooking(
      id: json['id'],
      userId: json['user_id'],
      roomId: json['room_id'],
      tripId: json['trip_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
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
      'room_id': roomId,
      'trip_id': tripId,
      'check_in': checkIn,
      'check_out': checkOut,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'rating': rating,
      'total_price': totalPrice,
      'cancel_reason': cancelReason,
      'booking_code': bookingCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
