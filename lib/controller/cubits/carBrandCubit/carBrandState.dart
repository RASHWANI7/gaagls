import 'package:gaagls/model/carBrand.dart';

abstract class CarBrandsState {}

class CarBrandsInitial extends CarBrandsState {}


class CarBrandsLoading extends CarBrandsState {}

class CarBrandsSuccess extends CarBrandsState {
  final List<CarBrand> carbrands;
  CarBrandsSuccess({
    List<CarBrand>? carbrands,
  }) : carbrands = carbrands ?? [];
}

class CarBrandsFailure extends CarBrandsState {
  final String error;
  CarBrandsFailure({required this.error});
}