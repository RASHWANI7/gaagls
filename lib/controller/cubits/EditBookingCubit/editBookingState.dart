import 'package:gaagls/model/bookingType.dart';

abstract class Editbookingstate {}

class EditbookingInitial extends Editbookingstate {}

class EditbookingLoading extends Editbookingstate {}

class EditbookingLoaded extends Editbookingstate {
  final String message;
  EditbookingLoaded({required this.message});
}

class EditbookingError extends Editbookingstate {
  final String message;
  EditbookingError({required this.message});
}
