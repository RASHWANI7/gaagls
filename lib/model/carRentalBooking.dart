class CarRentalBooking {
  final int id;
  final int userId;
  final int carRentalCarId;
  final String start;
  final String end;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final int rating;
  final int totalPrice;
  final String bookingCode;
  final String createdAt;
  final String updatedAt;

  CarRentalBooking({
    required this.id,
    required this.userId,
    required this.carRentalCarId,
    required this.start,
    required this.end,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.rating,
    required this.totalPrice,
    required this.bookingCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarRentalBooking.fromJson(Map<String, dynamic> json) {
    return CarRentalBooking(
      id: json['id'],
      userId: json['user_id'],
      carRentalCarId: json['car_rental_car_id'],
      start: json['start'],
      end: json['end'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
      rating: json['rating'],
      totalPrice: json['total_price'],
      bookingCode: json['booking_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'car_rental_car_id': carRentalCarId,
      'start': start,
      'end': end,
      'status': status,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'rating': rating,
      'total_price': totalPrice,
      'booking_code': bookingCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
