import 'package:gaagls/model/carBrand.dart';
import 'package:gaagls/model/destination.dart';
import '../../../model/airline.dart';
import '../../../model/hotel.dart';
import '../../../model/resturant.dart';
import '../../../model/trip.dart';

class SearchState {
  final List<CarBrand> carBrands;
  final List<Hotel> hotels;
  final List<Resturant> restaurants;
  final List<Trip> trips;
  final List<Destination> destinations;
  final bool isLoading;
  final String selectedFilter;
  final String error;
  final bool hasSearched;

  SearchState({
    required this.carBrands,
    required this.hotels,
    required this.restaurants,
    required this.trips,
    required this.destinations,
    required this.selectedFilter,
    required this.isLoading,
    required this.error,
    required this.hasSearched,
  });

  factory SearchState.initial() => SearchState(
    carBrands: [],
    hotels: [],
    restaurants: [],
    trips: [],
    destinations: [],
    selectedFilter: 'all',
    isLoading: false,
    error: '',
    hasSearched: false,
  );

  SearchState copyWith({
    List<CarBrand>? carBrands,
    List<Hotel>? hotels,
    List<Resturant>? restaurants,
    List<Trip>? trips,
    List<Destination>? destinations,
    bool? isLoading,
    String? selectedFilter,
    String? error,
    bool? hasSearched,
  }) {
    return SearchState(
      carBrands: carBrands ?? this.carBrands,
      hotels: hotels ?? this.hotels,
      restaurants: restaurants ?? this.restaurants,
      trips: trips ?? this.trips,
      destinations: destinations ?? this.destinations,
      isLoading: isLoading ?? this.isLoading,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      error: error ?? this.error,
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}
