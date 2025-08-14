// import 'dart:io';
// import 'package:flutter/foundation.dart';
//
// @immutable
// abstract class ProfileState {}
//
// class ProfileInitial extends ProfileState {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String image;
//
//   ProfileInitial({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.image,
//   });
// }
//
// class ProfileImagePicked extends ProfileState {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final File imageFile;
//
//   ProfileImagePicked({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.imageFile,
//   });
// }
//
// class ProfileLoading extends ProfileState {}
//
// class ProfileSaved extends ProfileState {}
//
// class ProfileError extends ProfileState {
//   final String error;
//   ProfileError({required this.error});
// }


// profile_state.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState{}

class ProfileSuccess extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  ProfileSuccess({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });
}

class ProfileImagePicked extends ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final File imageFile;

  ProfileImagePicked({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageFile,
  });
}

class ProfileLoading extends ProfileState {}


class ProfileError extends ProfileState {
  final String error;
  ProfileError({required this.error});
}

class ProfileForgetPassword extends ProfileState{
  final String message;

  ProfileForgetPassword({required this.message});
}

class ProfileForgetPasswordFailure extends ProfileState{
  final String message;

  ProfileForgetPasswordFailure({required this.message});
}

class ProfileForgetPasswordLoading extends ProfileState {}

