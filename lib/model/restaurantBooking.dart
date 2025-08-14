class RestaurantBooking {
  final int id;
  final int userId;
  final int restaurantId;
  final int numberOfSeats;
  final String location;
  final String date;
  final String start;
  final String end;
  final int tableId;
  final String status;
  final String bookingCode;
  final int rating;
  final String createdAt;
  final String updatedAt;

  RestaurantBooking({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.numberOfSeats,
    required this.location,
    required this.date,
    required this.start,
    required this.end,
    required this.tableId,
    required this.status,
    required this.bookingCode,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RestaurantBooking.fromJson(Map<String, dynamic> json) {
    return RestaurantBooking(
      id: json['id'],
      userId: json['user_id'],
      restaurantId: json['restaurant_id'],
      numberOfSeats: json['number_of_seats'],
      location: json['location'],
      date: json['date'],
      start: json['start'],
      end: json['end'],
      tableId: json['table_id'],
      status: json['status'],
      bookingCode: json['booking_code'],
      rating: json['rating'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'restaurant_id': restaurantId,
      'number_of_seats': numberOfSeats,
      'location': location,
      'date': date,
      'start': start,
      'end': end,
      'table_id': tableId,
      'status': status,
      'booking_code': bookingCode,
      'rating': rating,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
