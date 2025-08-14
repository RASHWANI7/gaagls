abstract class Loginstate {
  const Loginstate();

}

class loginInitial extends Loginstate{}

class loginLoading extends Loginstate{}

class loginSuccess extends Loginstate{
  final String message;
  loginSuccess({required this.message});
}

class loginFailure extends Loginstate{
  final String message;

  loginFailure(this.message);
}

class loginNeedVerify extends Loginstate{
  final String message;
  final int userId;
  loginNeedVerify({required this.message,required this.userId});
}

class loginForgetPassword extends Loginstate{
  final String message;

  loginForgetPassword({required this.message});
}

class loginForgetPasswordFailure extends Loginstate{
  final String message;

  loginForgetPasswordFailure({required this.message});
}

