class Airline {
  final int airlineId;
  final String airlineName;
  final int usereId;
  final int cityId;
  final int countryId;
  final String location;
  final String image;
  final String description;
  final int stars;
  final String status;
  final String created_at;
  final String updated_at;


  Airline({
    required this.airlineId,
    required this.airlineName,
    required this.usereId,
    required this.cityId,
    required this.countryId,
    required this.location,
    required this.image,
    required this.description,
    required this.stars,
    required this.status,
    required this.created_at,
    required this.updated_at,

  });

  factory Airline.fromJson(Map<String, dynamic> json) {
    return Airline(
      airlineId: (json['id'] as num?)?.toInt() ?? 0,
      airlineName: json['name'] ?? '',
      usereId: (json['user_id'] as num?)?.toInt() ?? 0,
      cityId: (json['city_id'] as num?)?.toInt() ?? 0,
      countryId: (json['country_id'] as num?)?.toInt() ?? 0,
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      stars: (json['stars'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
    );
  }
}