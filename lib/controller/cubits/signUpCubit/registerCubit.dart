import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/signUpCubit/registerState.dart';
import 'package:gaagls/model/cities.dart';
import 'package:gaagls/view/widgets/myDialog.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../globals/globals.dart';



class RegisterCubit extends Cubit<Registerstate>{
  RegisterCubit(): super(registerInitial());

  List<Cities> citiesList=[];
  Cities? selectedCity;

  Future<void> Register({required String firstName,required String lastName,required String email,required String password,required String confirmPassword,required int cityId, required BuildContext context})async {
    emit(registerLoading());
    try {
      Response response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/register'),
        body: json.encode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'city_id': cityId,
        }),
        headers: {
          'Content-type': 'application/json',
        },
      );
      print(response.statusCode);
       if (response.statusCode == 200) { // حالة الأخطاء في الإدخال

        final message = jsonDecode(response.body)['message'];
        final userId = jsonDecode(response.body)['user_id'];
        print(message);
        print(userId);
        emit(registerSuccess(message: message,userId: userId));
      }
      else if(response.statusCode==422){
        final message = jsonDecode(response.body)['message'];
        emit(registerFailure(error: message));
        print(response.statusCode);
        print(message);
      }
    } catch (e) {}
  }



  Future<List<Cities>> getCountries() async {
    try {
      Response response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/show/cities'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        if (jsonData.containsKey('cities')) {
          List<dynamic> citiesJson = jsonData['cities'];
          citiesList = citiesJson.map((city) => Cities.fromJson(city)).toList();
          print(citiesList.toString());
        }
       //   emit(getContriesState(cities: citiesList));
        return citiesList;
      }
    } catch (e) {
      print("Error fetching cities: $e");
    }
    return [];
  }

  void updateSelectedCity(Cities city) {
    selectedCity = city;
    emit(SelectedCityChanged(selectedCity: city));// فقط لإجبار BlocBuilder على إعادة البناء إن لزم
  }


  @override
  void onChange(Change<Registerstate> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }


}