import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/carBrandCubit/carBrandState.dart';
import 'package:gaagls/model/carBrand.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';

class CarBrandsCubit extends Cubit<CarBrandsState> {
  CarBrandsCubit() : super(CarBrandsInitial());

  Future<void> getCarBrands() async {
    emit(CarBrandsLoading());

    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;
    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/car/car_by_brand/$cityId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(token);
      print(cityId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        List<CarBrand> carbrandsList = [];

        print(carbrandsList);


        if (jsonResponse['brands'] != null &&
            jsonResponse['brands'] is List) {
          (jsonResponse['brands'] as List).forEach((v) {
            carbrandsList.add(CarBrand.fromJson(v));
          });
        }

        emit(CarBrandsSuccess(
          carbrands: carbrandsList,
        ));
      } else {
        emit(CarBrandsFailure(error: 'Failed To Load Data'));
      }
    } catch (e) {
      emit(CarBrandsFailure(error: e.toString()));
    }
  }

  @override
  void onChange(Change<CarBrandsState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }
}