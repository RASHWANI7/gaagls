import 'package:gaagls/model/hotel.dart';

import '../../../model/trip.dart';


abstract class TripsState {}

class TripsInitial extends TripsState {}


class TripsLoading extends TripsState {}

class TripsSuccess extends TripsState {
  final List<Trip> trips;
  TripsSuccess({
    List<Trip>? trips,
  }) : trips = trips ?? [];


  TripsSuccess copyWith({List<Trip>? trips}) {
    return TripsSuccess(
      trips: trips ?? this.trips,
    );
  }
}

class TripsFailure extends TripsState {
  final String error;
  TripsFailure({required this.error});
}
