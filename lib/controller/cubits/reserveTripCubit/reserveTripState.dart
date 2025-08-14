// import 'package:flutter/foundation.dart';
// import 'package:gaagls/model/tripStop.dart';
//
// @immutable
// abstract class ReserveTripState {}
//
// class ReservationInitial extends ReserveTripState {}
//
// class ReservationLoading extends ReserveTripState {}
//
// class ParkingLoaded extends ReserveTripState {
//   final List<TripStop> parkings;
//   ParkingLoaded(this.parkings);
// }
//
// class SeatLoaded extends ReserveTripState {
//   final List<String> seats;
//   SeatLoaded(this.seats);
// }
//
// class RoomLoaded extends ReserveTripState {
//   final List<String> rooms;
//   RoomLoaded(this.rooms);
// }
//
// class TicketLoaded extends ReserveTripState {
//   final List<String> tickets;
//   TicketLoaded(this.tickets);
// }
//
// class ReservationError extends ReserveTripState {
//   final String message;
//   ReservationError(this.message);
// }



import 'package:equatable/equatable.dart';

import '../../../model/tripStop.dart';
import '../../../model/tripStopSeats.dart';

class TripReserveState extends Equatable {
  final List<TripStop> tripStops;
  final List<TripStopSeat> tripStopSeats;
  final List<String> types_of_room;
  final List<int> capacities;

  final TripStop? selectedTripStop;
  final TripStopSeat? selectedSeat;
  final String? selectedType;
  final int? selectedCapacity;
  final String? selectedPaymentMethod;

  final Map<String, dynamic>? tripPriceDetails;

  final String? successMessage;

  final bool isLoading;
  final String? errorMessage;

  const TripReserveState({
    this.tripStops = const [],
    this.tripStopSeats = const [],
    this.types_of_room = const [],
    this.capacities = const [],
    this.selectedTripStop,
    this.selectedSeat,
    this.selectedType,
    this.selectedCapacity,
    this.isLoading = false,
    this.selectedPaymentMethod,
    this.tripPriceDetails,
    this.successMessage,
    this.errorMessage,
  });

  TripReserveState copyWith({
    List<TripStop>? tripStops,
    List<TripStopSeat>? tripStopSeats,
    List<String>? types_of_room,
    List<int>? capacities,
    TripStop? selectedTripStop,
    TripStopSeat? selectedSeat,
    String? selectedType,
    int? selectedCapacity,
    bool? isLoading,
    String? selectedPaymentMethod,
    Map<String, dynamic>? tripPriceDetails,
    String? successMessage,
    String? errorMessage,
  }) {
    return TripReserveState(
      tripStops: tripStops ?? this.tripStops,
      tripStopSeats: tripStopSeats ?? this.tripStopSeats,
      types_of_room: types_of_room ?? this.types_of_room,
      capacities: capacities ?? this.capacities,
      selectedTripStop: selectedTripStop ?? this.selectedTripStop,
      selectedSeat: selectedSeat ?? this.selectedSeat,
      selectedType: selectedType ?? this.selectedType,
      selectedCapacity: selectedCapacity ?? this.selectedCapacity,
      isLoading: isLoading ?? this.isLoading,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      tripPriceDetails: tripPriceDetails ?? this.tripPriceDetails,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage,
    );
  }

  // TripReserveState copyWith({
  //   List<TripStop>? tripStops,
  //   TripStop? selectedTripStop,
  //   List<TripStopSeat>? tripStopSeats,
  //   TripStopSeat? selectedSeat,
  //   List<String>? types,
  //   String? selectedType,
  //   List<int>? capacities,
  //   int? selectedCapacity,
  //   bool? isLoading,
  //   String? errorMessage,
  // }) {
  //   return TripReserveState(
  //     tripStops: tripStops ?? this.tripStops,
  //     selectedTripStop: selectedTripStop,
  //     tripStopSeats: tripStopSeats ?? this.tripStopSeats,
  //     selectedSeat: selectedSeat,
  //     types: types ?? this.types,
  //     selectedType: selectedType,
  //     capacities: capacities ?? this.capacities,
  //     selectedCapacity: selectedCapacity,
  //     isLoading: isLoading ?? this.isLoading,
  //     errorMessage: errorMessage,
  //   );
  // }


  @override
  List<Object?> get props => [
    tripStops,
    tripStopSeats,
    types_of_room,
    capacities,
    selectedTripStop,
    selectedSeat,
    selectedType,
    selectedCapacity,
    isLoading,
    selectedPaymentMethod,
    successMessage,
    errorMessage,
  ];
}
