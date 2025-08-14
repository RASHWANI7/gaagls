abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpValid extends OtpState {
  final String code;
  OtpValid(this.code);
}

class OtpInvalid extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;
  OtpSuccess({required this.message});
}

class OtpFailure extends OtpState {
  final String error;
  OtpFailure({required this.error});
}

class ResendOtpSuccess extends OtpState {
  final String message;
  ResendOtpSuccess({required this.message});
}

class ResendOtpFailure extends OtpState {
  final String error;
  ResendOtpFailure({required this.error});
}