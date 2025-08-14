import 'package:gaagls/model/airline.dart';
import 'package:gaagls/model/hotel.dart';

import '../../../model/trip.dart';


abstract class AirLinesState {}

class AirLinesInitial extends AirLinesState {}


class AirLinesLoading extends AirLinesState {}

class AirLinesSuccess extends AirLinesState {
  final List<Airline> airlines;
  AirLinesSuccess({
    List<Airline>? airlines,
  }) : airlines = airlines ?? [];
}

class AirLinesFailure extends AirLinesState {
  final String error;
  AirLinesFailure({required this.error});
}
