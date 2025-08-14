class CarRentalShop {
  final int userId;
  final int cityId;
  final int countryId;
  final String name;
  final String location;
  final int stars;
  final String status;
  final String description;
  final String image;

  CarRentalShop({
    required this.userId,
    required this.cityId,
    required this.countryId,
    required this.name,
    required this.location,
    required this.stars,
    required this.status,
    required this.description,
    required this.image,
  });

  factory CarRentalShop.fromJson(Map<String, dynamic> json) {
    return CarRentalShop(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      cityId: (json['city_id'] as num?)?.toInt() ?? 0,
      countryId: (json['country_id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      stars: (json['stars'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}