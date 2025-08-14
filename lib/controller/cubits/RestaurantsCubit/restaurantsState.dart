import 'package:gaagls/model/hotel.dart';
import 'package:gaagls/model/resturant.dart';

abstract class RestaurantsState {}

class RestaurantsInitial extends RestaurantsState {}


class RestaurantsLoading extends RestaurantsState {}

class RestaurantsSuccess extends RestaurantsState {
  final List<Resturant> restaurants;
  RestaurantsSuccess({
    List<Resturant>? restaurants,
  }) : restaurants = restaurants ?? [];

  RestaurantsSuccess copyWith({List<Resturant>? restaurants}) {
    return RestaurantsSuccess(
      restaurants: restaurants ?? this.restaurants,
    );
  }
}

class RestaurantsFailure extends RestaurantsState {
  final String error;
  RestaurantsFailure({required this.error});
}

class RestaurantsBookingSuccess extends RestaurantsState{
  final String message;
  RestaurantsBookingSuccess({required this.message});
}

class RestaurantsBookingFailure extends RestaurantsState{
  final String message;
  RestaurantsBookingFailure({required this.message});
}
