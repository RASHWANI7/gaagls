class Airlineflights {
  final int id;
  final int airlineId;
  final int cityId;
  final int flightNumber;
  final String flightDate;
  final String depatureTime;
  final String arrivalTime;
  final int price;
  final String status;


  Airlineflights({
    required this.id,
    required this.airlineId,
    required this.flightNumber,
    required this.cityId,
    required this.flightDate,
    required this.depatureTime,
    required this.arrivalTime,
    required this.status,
    required this.price,
  });

  factory Airlineflights.fromJson(Map<String, dynamic> json) {
    return Airlineflights(
      id: (json['id'] as num?)?.toInt() ?? 0,
      airlineId: (json['airline_id'] as num?)?.toInt() ?? 0,
      cityId: (json['city_id'] as num?)?.toInt() ?? 0,
      flightNumber: (json['flight_number'] as num?)?.toInt() ?? 0,
      flightDate: json['flight_date'] ?? '',
      depatureTime: json['depature_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? '',
    );
  }
}