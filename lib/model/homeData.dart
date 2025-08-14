import 'package:gaagls/model/carBrand.dart';
import 'package:gaagls/model/destination.dart';
import 'package:gaagls/model/hotel.dart';
import 'package:gaagls/model/resturant.dart';
import 'package:gaagls/model/trip.dart';

class HomeData {
  final List<Hotel> hotels;
  final List<Resturant> restaurants;
  final List<Destination> destinations;
  final List<Trip> trips;
  final List<CarBrand> carsBrand;

  HomeData({
    required this.hotels,
    required this.restaurants,
    required this.destinations,
    required this.trips,
    required this.carsBrand,
  });

  // factory HomeData.fromJson(Map<String, dynamic> json) {
  //   return HomeData(
  //     hotels: (json['hotels'] as List)
  //         .map((e) => Hotel.fromJson(e))
  //         .toList(),
  //     restaurants: (json['restaurants'] as List)
  //         .map((e) => Resturant.fromJson(e))
  //         .toList(),
  //     destinations: (json['destinations'] as List)
  //         .map((e) => Destination.fromJson(e))
  //         .toList(),
  //     trips: (json['trips'] as List)
  //         .map((e) => Trip.fromJson(e))
  //         .toList(),
  //     cars: (json['cars'] as List)
  //         .map((e) => CarBrand.fromJson(e))
  //         .toList(),
  //   );
  // }

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      hotels: (json['hotels'] is List)
          ? (json['hotels'] as List).map((e) => Hotel.fromJson(e)).toList()
          : [],
      restaurants: (json['restaurants'] is List)
          ? (json['restaurants'] as List).map((e) => Resturant.fromJson(e)).toList()
          : [],
      destinations: (json['destinations'] is List)
          ? (json['destinations'] as List).map((e) => Destination.fromJson(e)).toList()
          : [],
      trips: (json['trips'] is List)
          ? (json['trips'] as List).map((e) => Trip.fromJson(e)).toList()
          : [],
      carsBrand: (json['cars'] is List)
          ? (json['cars'] as List).map((e) => CarBrand.fromJson(e)).toList()
          : [],
    );
  }


  HomeData copyWith({
    List<Hotel>? hotels,
    List<Resturant>? restaurants,
    List<Destination>? destinations,
    List<Trip>? trips,
    List<CarBrand>? carsBrand,
  }) {
    return HomeData(
      hotels: hotels ?? this.hotels,
      restaurants: restaurants ?? this.restaurants,
      destinations: destinations ?? this.destinations,
      trips: trips ?? this.trips,
      carsBrand: carsBrand ?? this.carsBrand,
    );
  }
}


