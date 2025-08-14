import 'package:gaagls/model/hotel.dart';


abstract class HotelsState {}

class HotelsInitial extends HotelsState {}


class HotelsLoading extends HotelsState {}

class HotelsSuccess extends HotelsState {
  final List<Hotel> hotels;
  HotelsSuccess({
    List<Hotel>? hotels,
  }) : hotels = hotels ?? [];

  HotelsSuccess copyWith({List<Hotel>? hotels}) {
    return HotelsSuccess(
      hotels: hotels ?? this.hotels,
    );
  }
}

class HotelsFailure extends HotelsState {
  final String error;
  HotelsFailure({required this.error});
}
