
import 'package:equatable/equatable.dart';
import 'package:gaagls/model/airlineSeats.dart';
import 'package:gaagls/model/airlineflights.dart';
import '../../../model/tripStop.dart';
import '../../../model/tripStopSeats.dart';

class AirlineReserveState extends Equatable {
  final List<Airlineflights> airLineFlights;
  final List<AirLineSeats> airLineSeats;
  final List<int> capacities;

  final Airlineflights? selectedAirlineFlight;
  final AirLineSeats? selectedAirlineSeats;
  final int? selectedCapacity;
  final String? selectedPaymentMethod;

  final Map<String, dynamic>? tripPriceDetails;

  final String? successMessage;
  final bool isLoading;
  final String? errorMessage;

  const AirlineReserveState({
    this.airLineFlights = const [],
    this.airLineSeats = const [],
    this.capacities = const [],
    this.selectedAirlineFlight,
    this.selectedAirlineSeats,
    this.selectedCapacity,
    this.isLoading = false,
    this.selectedPaymentMethod,
    this.tripPriceDetails,
    this.successMessage,
    this.errorMessage,
  });

  AirlineReserveState copyWith({
    List<Airlineflights>? airLineFlights,
    List<AirLineSeats>? airLineSeats,
    List<int>? capacities,
    Airlineflights? selectedAirlineFlight,
    AirLineSeats? selectedAirlineSeats,
    int? selectedCapacity,
    bool? isLoading,
    String? selectedPaymentMethod,
    Map<String, dynamic>? tripPriceDetails,
    String? successMessage,
    String? errorMessage,
  }) {
    return AirlineReserveState(
      airLineFlights: airLineFlights ?? this.airLineFlights,
      airLineSeats: airLineSeats ?? this.airLineSeats,
      capacities: capacities ?? this.capacities,
      selectedAirlineFlight: selectedAirlineFlight ?? this.selectedAirlineFlight,
      selectedAirlineSeats: selectedAirlineSeats ?? this.selectedAirlineSeats,
      selectedCapacity: selectedCapacity ?? this.selectedCapacity,
      isLoading: isLoading ?? this.isLoading,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      tripPriceDetails: tripPriceDetails ?? this.tripPriceDetails,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage,
    );
  }


  @override
  List<Object?> get props => [
    airLineFlights,
    airLineSeats,
    capacities,
    selectedAirlineFlight,
    selectedAirlineSeats,
    selectedCapacity,
    isLoading,
    selectedPaymentMethod,
    successMessage,
    errorMessage,
  ];
}
