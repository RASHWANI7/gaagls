import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constants.dart';
import 'logInState.dart';
import 'package:http/http.dart' as http;

class LoginCubit extends Cubit<Loginstate> {
  LoginCubit() : super(loginInitial());

  Future<void> login({required String email, required String password,required bool rememberMe ,required BuildContext context}) async {
    emit(loginLoading());
    print(rememberMe);
    try {
      final Uri apiUrl = Uri.parse('${Globals().ngrok}/api/user/login');

      final Response response = await http.post(
        apiUrl,
        body: jsonEncode({
          'email': email,
          'password': password,
          'remember_me': rememberMe,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');



      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        final message = jsonDecode(response.body)['message'];
        final String userToken = jsonResponse['token'];
        final needToVerify = jsonDecode(response.body)['need_verify'];
        final cityId = jsonDecode(response.body)['city_id'];

         // print('The token is: $userToken');
          print(message);
          print(cityId);

        Globals().saveTokenAndCityId(token: userToken,city_id:  cityId);


          emit(loginSuccess(message: message));

          // try {
          //   SharedPreferences prefs = await SharedPreferences.getInstance();
          //   await prefs.setString(Constants.Access_Token, userToken);
          //   await _saveLoginStatus(true);
          //
          //   emit(loginSuccess());
          // } catch (e) {
          //   emit(loginFailure('خطأ في حفظ بيانات المستخدم.'));
          // }

      } else if (response.statusCode == 422) { // حالة الأخطاء في الإدخال
        final errorMessage = jsonDecode(response.body)['message'];
        emit(loginFailure(errorMessage));
      }else if(response.statusCode==403){
        final errorMessage = jsonDecode(response.body)['message'];
        final userId = jsonDecode(response.body)['user_id'];
        emit(loginNeedVerify(message: errorMessage,userId: userId));
      }
      else {
        emit(loginFailure('فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.'));
      }
    } catch (e) {
      emit(loginFailure('خطأ أثناء تسجيل الدخول: $e'));
    }
  }


  Future<void> forgetPassword({required String email ,required BuildContext context})async {
    emit(loginLoading());
    try {
      Response response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/forgotpass'),
        body: json.encode({
          'email': email,
        }),
        headers: {
          'Content-type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {

        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(loginForgetPassword(message: message));
      }
      else if(response.statusCode==422){
        final error = jsonDecode(response.body)['message'];
        emit(loginForgetPasswordFailure(message: error));
        print(error);
      }
    } catch (e) {}
  }


  // // دالة حفظ حالة تسجيل الدخول
  // Future<void> _saveLoginStatus(bool isLoggedIn) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isLoggedIn', isLoggedIn);
  // }
  //
  // // دالة للتحقق مما إذا كان المستخدم قد سجل الدخول مسبقًا
  // Future<void> checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //
  //   if (isLoggedIn) {
  //     emit(loginSuccess());
  //   } else {
  //     emit(loginInitial()); // إعادة المستخدم إلى صفحة تسجيل الدخول
  //   }
  // }


  @override
  void onChange(Change<Loginstate> change) {
    // TODO: implement onChange

    super.onChange(change);
    print(change);
  }



}