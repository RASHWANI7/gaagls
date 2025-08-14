
class TripActivity {
  final int id;
  final String activityName;
  final String description;
  final String date;
  final String start;
  final String end;

  TripActivity({
    required this.id,
    required this.activityName,
    required this.description,
    required this.date,
    required this.start,
    required this.end,
  });

  factory TripActivity.fromJson(Map<String, dynamic> json) {
    return TripActivity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      activityName: json['activity_name'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      start: json['start'] ?? '',
      end: json['end'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity_name': activityName,
      'description': description,
      'date': date,
      'start': start,
      'end': end,
    };
  }
}

class Trip {
  final int tripId;
  final int tourist_office_id;
  final String tourist_office_name;
  final String tourist_office_city;
  final int tourist_office_countryId;
  final String tourist_office_country;
  final String tripName;
  final String start;
  final String end;
  final int tripPrice;
  final int destinationId;
  final String destination;
  final String tripImage;
  final String description;
  final int trip_hotel_id;
  final String trip_hotel_name;
  final String trip_hotel_location;
  final int trip_hotel_stars;
  final List<TripActivity> tripActivities;
  final bool isFavorite;





  Trip({
    required this.tripId,
    required this.tourist_office_id,
    required this.tourist_office_name,
    required this.tourist_office_city,
    required this.tourist_office_countryId,
    required this.tourist_office_country,
    required this.tripName,
    required this.start,
    required this.end,
    required this.tripPrice,
    required this.destinationId,
    required this.destination,
    required this.tripImage,
    required this.description,
    required this.trip_hotel_id,
    required this.trip_hotel_name,
    required this.trip_hotel_location,
    required this.trip_hotel_stars,
    required this.tripActivities,
    this.isFavorite = false,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    var activitiesFromJson = json['trip_activities'] as List<dynamic>? ?? [];
    List<TripActivity> activitiesList = activitiesFromJson
        .map((activityJson) => TripActivity.fromJson(activityJson))
        .toList();

    return Trip(
      tripId: (json['id'] as num?)?.toInt() ?? 0,
      tourist_office_id: (json['tourist_office_id'] as num?)?.toInt() ?? 0,
      tourist_office_name: json['tourist_office_name'] ?? '',
      tourist_office_city: json['city'] ?? '',
      tourist_office_countryId: (json['country_id'] as num?)?.toInt() ?? 0,
      tourist_office_country: json['country'] ?? '',
      tripName: json['name'] ?? '',
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      tripPrice: (json['price'] as num?)?.toInt() ?? 0,
      destinationId: (json['destination_id'] as num?)?.toInt() ?? 0,
      destination: json['destination'] ?? '',
      tripImage: json['image'] ?? '',
      description: json['description'] ?? '',
      trip_hotel_id: (json['trip_hotel_id'] as num?)?.toInt() ?? 0,
      trip_hotel_name: json['trip_hotel_name'] ?? '',
      trip_hotel_location: json['trip_hotel_location'] ?? '',
      trip_hotel_stars: (json['trip_hotel_stars'] as num?)?.toInt() ?? 0,
      tripActivities: activitiesList,
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': tripId,
      'tourist_office_id': tourist_office_id,
      'tourist_office_name': tourist_office_name,
      'city': tourist_office_city,
      'country_id': tourist_office_countryId,
      'country': tourist_office_country,
      'name': tripName,
      'start': start,
      'end': end,
      'price': tripPrice,
      'destination_id': destinationId,
      'destination': destination,
      'image': tripImage,
      'description': description,
      'trip_hotel_id': trip_hotel_id,
      'trip_hotel_name': trip_hotel_name,
      'trip_hotel_location': trip_hotel_location,
      'trip_hotel_stars' : trip_hotel_stars,
      'trip_activities': tripActivities.map((a) => a.toJson()).toList(),
      'isFavorite': isFavorite,
    };
  }

  Trip copyWith({
    bool? isFavorite,
  }) {
    return Trip(
      tripId: tripId,
      tourist_office_id: tourist_office_id,
      tourist_office_name: tourist_office_name,
      tourist_office_city: tourist_office_city,
      tourist_office_countryId: tourist_office_countryId,
      tourist_office_country: tourist_office_country,
      tripName: tripName,
      start: start,
      end: end,
      tripPrice: tripPrice,
      destinationId: destinationId,
      destination: destination,
      tripImage: tripImage,
      description: description,
      trip_hotel_id: trip_hotel_id,
      trip_hotel_name: trip_hotel_name,
      trip_hotel_location: trip_hotel_location,
      trip_hotel_stars: trip_hotel_stars,
      tripActivities: tripActivities,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

}
