import 'package:gaagls/model/car.dart';
import 'package:gaagls/model/hotel.dart';
import 'package:gaagls/model/resturant.dart';
import 'package:gaagls/model/trip.dart';
import 'package:gaagls/model/destination.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final List<Car> cars;
  final List<Hotel> hotels;
  final List<Resturant> restaurants;
  final List<Trip> trips;
  final List<Destination> destinations;
  // إضافة خاصية الفلتر
  final String selectedFilter;

  FavoriteSuccess({
    required this.cars,
    required this.hotels,
    required this.restaurants,
    required this.trips,
    required this.destinations,
    this.selectedFilter = 'all',  // القيمة الافتراضية
  });

  FavoriteSuccess copyWith({
    List<Car>? cars,
    List<Hotel>? hotels,
    List<Resturant>? restaurants,
    List<Trip>? trips,
    List<Destination>? destinations,
    String? selectedFilter,
  }) {
    return FavoriteSuccess(
      cars: cars ?? this.cars,
      hotels: hotels ?? this.hotels,
      restaurants: restaurants ?? this.restaurants,
      trips: trips ?? this.trips,
      destinations: destinations ?? this.destinations,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class FavoriteFailure extends FavoriteState {
  final String error;
  FavoriteFailure({required this.error});
}
