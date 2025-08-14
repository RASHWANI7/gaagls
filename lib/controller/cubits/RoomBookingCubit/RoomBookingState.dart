abstract class RoomBookingState{}

class RoomBookingInitial extends RoomBookingState {}

class RoomBookingLoading extends RoomBookingState {}

class RoomBookingSuccess extends RoomBookingState{
  final String message;
  RoomBookingSuccess({required this.message});
}

class RoomBookingFailure extends RoomBookingState{
  final String message;
  RoomBookingFailure({required this.message});
}