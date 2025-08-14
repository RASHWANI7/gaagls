class AirLineSeats {
  final int id;
  final int flightId;
  final String seatClass;
  final int seatCount;
  final int price;


  AirLineSeats({
    required this.id,
    required this.flightId,
    required this.seatClass,
    required this.seatCount,
    required this.price,
  });

  factory AirLineSeats.fromJson(Map<String, dynamic> json) {
    return AirLineSeats(
      id: (json['id'] as num?)?.toInt() ?? 0,
      flightId: (json['flight_id'] as num?)?.toInt() ?? 0,
      seatClass: json['seat_class'] ?? '',
      seatCount: (json['seat_count'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toInt() ?? 0,
    );
  }
}