import 'package:flutter/foundation.dart';

import '../../../model/car.dart';
import '../../../model/carBrand.dart';


@immutable
abstract class CarsState {}

class CarsInitial extends CarsState {}

class CarsLoading extends CarsState {}

// class CarsSuccess extends CarsState {
//   final List<CarBrand> brands;
//   final Map<String, List<Car>> brandCars;
//
//   CarsSuccess({
//     required this.brands,
//     required this.brandCars,
//   });
// }

class CarsSuccess extends CarsState {
  final List<CarBrand> brands;
  final Map<String, List<Car>> brandCars;

  CarsSuccess({
    required this.brands,
    required this.brandCars,
  });

  CarsSuccess copyWith({
    List<CarBrand>? brands,
    Map<String, List<Car>>? brandCars,
  }) {
    return CarsSuccess(
      brands: brands ?? this.brands,
      brandCars: brandCars ?? this.brandCars,
    );
  }
}


class CarsFailure extends CarsState {
  final String error;

  CarsFailure({required this.error});
}