


import '../../../model/destination.dart';

abstract class DestinationsState {}

class DestinationsInitial extends DestinationsState {}


class DestinationsLoading extends DestinationsState {}

class DestinationsSuccess extends DestinationsState {
  final List<Destination> destinations;
  DestinationsSuccess({
    List<Destination>? destinations,
  }) : destinations = destinations ?? [];

  DestinationsSuccess copyWith({List<Destination>? destinations}) {
    return DestinationsSuccess(
      destinations: destinations ?? this.destinations,
    );
  }
}

class DestinationsFailure extends DestinationsState {
  final String error;
  DestinationsFailure({required this.error});
}
