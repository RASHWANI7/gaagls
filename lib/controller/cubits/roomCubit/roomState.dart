
import '../../../model/room.dart';

abstract class RoomsState {}

class RoomsInitial extends RoomsState {}


class RoomsLoading extends RoomsState {}

class RoomsSuccess extends RoomsState {
  final List<Room> rooms;
  RoomsSuccess({
    List<Room>? rooms,
  }) : rooms = rooms ?? [];
}

class RoomsFailure extends RoomsState {
  final String error;
  RoomsFailure({required this.error});
}




