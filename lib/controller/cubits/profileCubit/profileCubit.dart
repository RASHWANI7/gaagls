import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/profileCubit/profileState.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../globals/globals.dart';
import '../../../model/userProfile.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    //loadProfileData();
  }

  Future<void> loadProfileData() async {
    emit(ProfileLoading());
    try {
      final user = await fetchUserProfile();
      emit(ProfileSuccess(
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        image: user.image,
      ));
    } catch (e) {
      emit(ProfileError(error: 'فشل تحميل البيانات. تأكد من الاتصال بالإنترنت.'));
    }
  }

  Future<UserProfile> fetchUserProfile() async {

    final token = await Globals().getToken();
    final uri = Uri.parse('${Globals().ngrok}/api/user/show');
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    print('profile status '+ response.statusCode.toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile(
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        image: data['image'],
      );
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? 'خطأ غير معروف');
    }
  }



  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      await _uploadImage(file);
    }
  }


  Future<void> _uploadImage(File imageFile) async {
    emit(ProfileLoading());
    try {
      final token = await Globals().getToken();
      final uri = Uri.parse('${Globals().ngrok}/api/user/update_pic');

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        await loadProfileData();
      } else {
        emit(ProfileError(error: 'فشل رفع الصورة: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ProfileError(error: 'حدث خطأ أثناء رفع الصورة: $e'));
    }
  }

  Future<void> saveProfile({required String firstName, required String lastName}) async {
    emit(ProfileLoading());
    try {
      final token = await Globals().getToken();
      final uri = Uri.parse('${Globals().ngrok}/api/user/update_info');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': firstName,
          'last_name': lastName,
        }),
      );

      if (response.statusCode == 200) {
        await loadProfileData();
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception('فشل: ${errorBody['message'] ?? 'خطأ غير معروف'}');
      }
    } catch (e) {
      emit(ProfileError(error: 'حدث خطأ أثناء حفظ البيانات: $e'));
    }
  }



  Future<void> forgetPassword({required String email })async {
    emit(ProfileLoading());

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
        emit(ProfileForgetPassword(message: message));
      }
      else if(response.statusCode==422){
        final error = jsonDecode(response.body)['message'];
        emit(ProfileForgetPasswordFailure(message: error));
        print(error);
      }
    } catch (e) {}
  }

}
