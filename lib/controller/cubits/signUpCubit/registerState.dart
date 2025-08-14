import 'package:gaagls/model/cities.dart';

abstract class Registerstate {
  const Registerstate();

}

class registerInitial extends Registerstate{}

class registerLoading extends Registerstate{}

class registerSuccess extends Registerstate{
  String message;
  int userId;
  registerSuccess({required this.message,required this.userId});
}

class registerFailure extends Registerstate{
  String error;
  registerFailure({required this.error});
}

// class getContriesState extends Registerstate{
//   List <Cities> cities=[];
//   getContriesState({required this.cities});
// }

class SelectedCityChanged extends Registerstate{
  final Cities selectedCity;
  SelectedCityChanged({required this.selectedCity});
}