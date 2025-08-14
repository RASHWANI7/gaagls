import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial()); // الحالة الابتدائية







  String _currentCode = ''; // تخزين الكود الحالي

  void codeChanged(String code) {//لاستقبال ال string كاملة
    _currentCode = code; // تحديث الكود
    if (_currentCode.length == 6) {
      emit(OtpValid(_currentCode));
    } else {
      emit(OtpInvalid());
    }
  }

  void printOtp(){
    print(_currentCode);
  }

  Future<void> Otp({required int userId ,required BuildContext context})async {
    emit(OtpLoading());


    try {
      Response response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/verify/email'),
        body: json.encode({
          'user_id': userId,
          'verification_code': _currentCode,
        }),
        headers: {
          'Content-type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) { // حالة الأخطاء في الإدخال

        final message = jsonDecode(response.body)['message'];
        final userToken = jsonDecode(response.body)['token'];
        final cityId = jsonDecode(response.body)['city_id'];

        print(message);
        print(userToken);
        print(cityId);

        Globals().saveTokenAndCityId(token: userToken,city_id:  cityId);

        emit(OtpSuccess(message: message));
      }
      else if(response.statusCode==422){
        final error = jsonDecode(response.body)['message'];
        emit(OtpFailure(error: error));

      }
    } catch (e) {}
  }


  Future<void> reSendOtp({required int userId ,required BuildContext context})async {
    emit(OtpLoading());
    try {
      Response response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/resend/verification/code'),
        body: json.encode({
          'user_id': userId,
        }),
        headers: {
          'Content-type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {

        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(ResendOtpSuccess(message: message));
      }
      else if(response.statusCode==422){
        final error = jsonDecode(response.body)['message'];
        emit(ResendOtpFailure(error: error));

      }
    } catch (e) {}
  }


  // Future<void> submitCode() async {
  //   emit(OtpSubmitting()); // بدء التحقق (تحميل)
  //
  //   await Future.delayed(const Duration(seconds: 1)); // محاكاة تأخير
  //
  //   if (_currentCode == '123456') {
  //     emit(OtpSuccess()); // نجاح التحقق
  //   } else {
  //     emit(OtpFailure()); // فشل التحقق
  //   }
  // }

  @override
  void onChange(Change<OtpState> change) {
    super.onChange(change);
    debugPrint('🔄 الحالة تغيّرت: ${change.currentState} → ${change.nextState}');
  }

}


