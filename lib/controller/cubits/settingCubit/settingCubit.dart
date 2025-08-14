import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/settingCubit/settingState.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/constants.dart';
import '../../../globals/globals.dart';
import '../../../model/cities.dart';


// class SettingsCubit extends Cubit<Settingstate> {
//   SettingsCubit(): super(SettingInitial()) ;
//
//   List<Cities> citiesList=[];
//   Cities? selectedCity;
//
//   Future<List<Cities>> getCountries() async {
//     emit(SettingLoading());
//     try {
//       Response response = await http.get(
//         Uri.parse('${Globals().ngrok}/api/user/show/cities'),
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData = jsonDecode(response.body);
//         if (jsonData.containsKey('cities')) {
//           List<dynamic> citiesJson = jsonData['cities'];
//           citiesList = citiesJson.map((city) => Cities.fromJson(city)).toList();
//           print(citiesList.toString());
//           emit(SettingSuccess(cities: citiesList, selectedCity: selectedCity));
//         }
//
//         return citiesList;
//       }
//     } catch (e) {
//       print("Error fetching cities: $e");
//     }
//     return [];
//   }
//
//   void updateSelectedCity(Cities city) {
//     selectedCity = city;
//     emit(SelectedCityChanged(selectedCity: city));// فقط لإجبار BlocBuilder على إعادة البناء إن لزم
//   }
//
//   Future<void> updateCountryInBackEnd({required Cities city})async{
//     emit(SettingLoading());
//     try{
//       Response response = await http.post(
//         Uri.parse('${Globals().ngrok}/api/user/change_country'),
//         body: json.encode({
//           'city_id': city.id,
//         }),
//         headers: {
//           'Content-type': 'application/json',
//           'Authorization': 'Bearer ${await Globals().getToken()}',
//         },
//       );
//
//       final String? token =  await Globals().getToken();
//
//       print(response.statusCode);
//       if (response.statusCode == 200) { // حالة الأخطاء في الإدخال
//
//         final message = jsonDecode(response.body)['message'];
//
//         print(message);
//         emit(SettingSuccess(cities: citiesList,selectedCity: selectedCity));
//         Globals().saveTokenAndCityId(token: token!,city_id: city.id);
//
//       }
//       else if(response.statusCode==422){
//         final message = jsonDecode(response.body)['message'];
//         emit(SettingFailure(error: message));
//         print(response.statusCode);
//         print(message);
//       }
//
//     }catch(e){}
//
//   }
//
//   void logout() async{
//
//     emit(SettingLogoutLoading());
//     try{
//       Response response = await http.post(
//         Uri.parse('${Globals().ngrok}/api/user/log_out'),
//         headers: {
//           'Content-type': 'application/json',
//           'Authorization': 'Bearer ${await Globals().getToken()}',
//         },
//       );
//
//
//       print(response.statusCode);
//       if (response.statusCode == 200) { // حالة الأخطاء في الإدخال
//
//         final message = jsonDecode(response.body)['message'];
//         print(message);
//         emit(SettingLogoutSuccess());
//       }
//       else if(response.statusCode==422){
//
//         final message = jsonDecode(response.body)['message'];
//         emit(SettingLogoutSuccess());
//         print(response.statusCode);
//         print(message);
//       }
//
//     }catch(e){}
//
//
//   }
// }


class SettingsCubit extends Cubit<Settingstate> {
  SettingsCubit() : super(SettingInitial()) {
    _loadSavedCity();
  }

  List<Cities> citiesList = [];
  Cities? selectedCity;

  Future<void> _loadSavedCity() async {
    final savedCityId = await Globals().getCityId();
    if (savedCityId != null) {
      // إذا كنت تخزن اسم المدينة أيضًا يمكن إضافته هنا
      selectedCity = Cities(id: savedCityId, city: '', created_at: '', updated_at: ''); // الاسم سيتم تحديثه بعد تحميل المدن
    }
    emit(SettingSuccess(cities: citiesList, selectedCity: selectedCity));
  }

  // Future<List<Cities>> getCountries() async {
  //   emit(SettingLoading());
  //   try {
  //     Response response = await http.get(
  //       Uri.parse('${Globals().ngrok}/api/user/show/cities'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonData = jsonDecode(response.body);
  //       if (jsonData.containsKey('cities')) {
  //         List<dynamic> citiesJson = jsonData['cities'];
  //         citiesList = citiesJson.map((city) => Cities.fromJson(city)).toList();
  //
  //         // تحديث selectedCity بالاسم الصحيح بعد تحميل المدن
  //         if (selectedCity != null) {
  //           final match = citiesList.firstWhere(
  //                 (c) => c.id == selectedCity!.id,
  //             orElse: () => citiesList.isNotEmpty ? citiesList[0] : selectedCity!,
  //           );
  //           selectedCity = match;
  //         }
  //
  //         emit(SettingSuccess(cities: citiesList, selectedCity: selectedCity));
  //       }
  //       return citiesList;
  //     } else {
  //       emit(SettingFailure(error: 'Failed to load cities'));
  //     }
  //   } catch (e) {
  //     emit(SettingFailure(error: 'Error fetching cities: $e'));
  //   }
  //   return [];
  // }

  Future<List<Cities>> getCountries() async {
    emit(SettingLoading());
    try {
      Response response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/show/cities'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('cities')) {
          List<dynamic> citiesJson = jsonData['cities'];
          citiesList = citiesJson.map((city) => Cities.fromJson(city)).toList();

          // 🔹 جلب الـ city_id من SharedPreferences
          int? savedCityId = await Globals().getCityId();

          // 🔹 البحث عن المدينة المطابقة
          if (savedCityId != null) {
            selectedCity = citiesList.firstWhere(
                  (city) => city.id == savedCityId,
              orElse: () => citiesList.first, // fallback لو ما وجد
            );
          }

          emit(SettingSuccess(
            cities: citiesList,
            selectedCity: selectedCity,
          ));
        }

        return citiesList;
      }
    } catch (e) {
      print("Error fetching cities: $e");
    }
    return [];
  }


  void updateSelectedCity(Cities city) {
    selectedCity = city;
    emit(SelectedCityChanged(selectedCity: city));
  }

  Future<void> updateCountryInBackEnd({required Cities city}) async {
    emit(SettingLoading());
    try {
      Response response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/change_country'),
        body: json.encode({'city_id': city.id}),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${await Globals().getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body)['message'];
        print(message);

        // حفظ المدينة الجديدة باستخدام Globals
        final token = await Globals().getToken();
        if (token != null) {
          await Globals().saveTokenAndCityId(token: token, city_id: city.id);
        }

        selectedCity = city;
        emit(SettingSuccess(cities: citiesList, selectedCity: selectedCity));
      } else {
        final message = jsonDecode(response.body)['message'];
        emit(SettingFailure(error: message));
      }
    } catch (e) {
      emit(SettingFailure(error: 'Error updating city: $e'));
    }
  }

  Future<void> logout() async{
    emit(SettingLogoutLoading());
    try{
      Response response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/logout'),
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${await Globals().getToken()}',
        },
      );


      print(response.statusCode);
      if (response.statusCode == 200) {

        final message = jsonDecode(response.body)['message'];
        print(message);

        await Globals().deleteToken();

        emit(SettingLogoutSuccess());
      }
      else if(response.statusCode==422){

        final message = jsonDecode(response.body)['message'];
        print(response.statusCode);
        print(message);

        emit(SettingLogoutFailure(error: message));
      }else{
        emit(SettingLogoutFailure(error: 'خطأ ما'));
      }

    }catch(e){}


  }
}
