class Hotel {
  final int hotelId;
  final String city;
  final int countryId;
  final String country;
  final String location;
  final String hotelName;
  final String description;
  final int stars;
  final String hotelImage;
  final bool isFavorite; // ✅ تمت الإضافة


  Hotel
  ({
  required this.hotelId,
  required this.city,
  required this.countryId,
  required this.country,
  required this.location,
  required this.hotelName,
  required this.description,
  required this.stars,
  required this.hotelImage,
    this.isFavorite = false, // ✅ الافتراضي
});



  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelId: (json['id'] as num).toInt() ,
      city: json['city'] ?? '' ,
      countryId: json['country_id'] != null ? (json['country_id'] as num).toInt() : 0,
      country: json['country'] ?? '',
      location: json['location'] ?? '',
      hotelName: json['name'] ?? '',
      description: json['description'] ?? '',
      stars: (json['stars'] as num).toInt(),
      hotelImage: json['image'] ?? '',
      isFavorite: json['is_favorite'] ?? false, // ✅ من API
    );
  }


  // تحويل البيانات إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : hotelId,
      'city': city,
      'country_id': countryId,
      'country': country,
      'location': location,
      'name': hotelName,
      'description': description,
      'stars': stars,
      'image': hotelImage,
      'isFavorite': isFavorite,
    };
  }


  Hotel copyWith({
    int? hotelId,
    String? city,
    int? countryId,
    String? country,
    String? location,
    String? hotelName,
    String? description,
    int? stars,
    String? hotelImage,
    bool? isFavorite,
  }) {
    return Hotel(
      hotelId: hotelId ?? this.hotelId,
      city: city ?? this.city,
      countryId: countryId ?? this.countryId,
      country: country ?? this.country,
      location: location ?? this.location,
      hotelName: hotelName ?? this.hotelName,
      description: description ?? this.description,
      stars: stars ?? this.stars,
      hotelImage: hotelImage ?? this.hotelImage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }



}



