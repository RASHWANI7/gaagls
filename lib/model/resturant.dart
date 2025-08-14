class Resturant {
  final int resturantId;
  final String city;
  final int countryId;
  final String country;
  final String resturantName;
  final String openTime;
  final String closeTime;
  final String resturantImage;
  final int stars;
  final String description;
  final String location;
  final bool isFavorite; // ✅ تمت الإضافة

  Resturant({
    required this.resturantId,
    required this.city,
    required this.countryId,
    required this.country,
    required this.resturantName,
    required this.openTime,
    required this.closeTime,
    required this.resturantImage,
    required this.stars,
    required this.description,
    required this.location,
    this.isFavorite = false, // ✅ الافتراضي
  });



  factory Resturant.fromJson(Map<String, dynamic> json) {
    return Resturant(
      resturantId: (json['id'] as num).toInt() ,
      city: json['city'] ,
      countryId: (json['country_id'] as num).toInt(),
      country: json['country'] ?? '',
      resturantName: json['name'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
      openTime: json['open'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
      closeTime: json['close'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
      resturantImage: json['image'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
      stars: (json['stars'] as num).toInt(),
      description: json['description'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
      location: json['location'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
      isFavorite: json['is_favorite'] ?? false, // ✅ من API
    );
  }


  // تحويل البيانات إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : resturantId,
      'city': city,
      'country_id': countryId,
      'country': country,
      'name': resturantName,
      'open': openTime,
      'close': closeTime,
      'image': resturantImage,
      'stars': stars,
      'description': description,
      'location': location,
      'isFavorite': isFavorite,
    };
  }

  Resturant copyWith({
    int? resturantId,
    String? city,
    int? countryId,
    String? country,
    String? resturantName,
    String? openTime,
    String? closeTime,
    String? resturantImage,
    int? stars,
    String? description,
    String? location,
    bool? isFavorite,
  }) {
    return Resturant(
      resturantId: resturantId ?? this.resturantId,
      city: city ?? this.city,
      countryId: countryId ?? this.countryId,
      country: country ?? this.country,
      resturantName: resturantName ?? this.resturantName,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      resturantImage: resturantImage ?? this.resturantImage,
      stars: stars ?? this.stars,
      description: description ?? this.description,
      location: location ?? this.location,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

}






