import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:http/http.dart' as http;
import '../../../model/car.dart';
import '../../../model/carBrand.dart';
import 'carScreenState.dart';

class CarsCubit extends Cubit<CarsState> {
  CarsCubit() : super(CarsInitial());

  List<CarBrand> brandsList = [];
  Map<String, List<Car>> brandCarsMap = {};
  bool isCarFavoriteUpdating = false;

  Future<void> getCars(String selectedBrand) async {
    emit(CarsLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int;


    try {
      final carsResponse = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/car_brand/$cityId'),
        body: jsonEncode({
          'brand': selectedBrand,
        }),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type': 'application/json',
        },

      );

      print(carsResponse.statusCode);

      if (carsResponse.statusCode == 200) {

        // 🧹 مسح القوائم القديمة
        brandsList.clear();
        brandCarsMap.clear();

        final carsJson = jsonDecode(carsResponse.body)['cars'] as List;
        print(carsJson);

        final cars = carsJson.map((e) => Car.fromJson(e)).toList();

        final filteredCars = cars.where((car) => car.brand == selectedBrand).toList();

        // final Map<String, List<Car>> brandCars = {
        //   selectedBrand: filteredCars,
        // };
        //
        // emit(CarsSuccess(brands: [], brandCars: brandCars));


        // تعبئة الخريطة العالمية
        brandCarsMap[selectedBrand] = filteredCars;

        // (بإمكانك تعبئة brandsList لاحقًا من endpoint آخر أو كما تريد)
        emit(CarsSuccess(brands: brandsList, brandCars: brandCarsMap));


      } else {
        emit(CarsFailure(error: 'فشل في تحميل السيارات'));
      }
    } catch (e) {
      emit(CarsFailure(error: e.toString()));
    }
  }




  Future<Map<String, dynamic>> toggleCarFavorite(Car car) async {
    if (isCarFavoriteUpdating || state is! CarsSuccess) {
      return {
        'success': false,
        'message': 'Please wait before trying again.',
        'car': car,
      };
    }

    isCarFavoriteUpdating = true;

    final oldIsFav = car.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as CarsSuccess;

    // تعديل قائمة السيارات داخل البراند المناسب
    final updatedBrandCars = Map<String, List<Car>>.from(s.brandCars);
    updatedBrandCars.forEach((brand, cars) {
      updatedBrandCars[brand] = cars.map((c) {
        return c.carId == car.carId ? c.copyWith(isFavorite: newIsFav) : c;
      }).toList();
    });

    emit(s.copyWith(brandCars: updatedBrandCars));

    final resp = await _updateCarFavoriteOnServer(car.carId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (!success) {
      // التراجع في حالة الفشل
      updatedBrandCars.forEach((brand, cars) {
        updatedBrandCars[brand] = cars.map((c) {
          return c.carId == car.carId ? c.copyWith(isFavorite: oldIsFav) : c;
        }).toList();
      });
      emit(s.copyWith(brandCars: updatedBrandCars));
    }

    isCarFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'car': success ? car.copyWith(isFavorite: newIsFav) : car,
    };
  }

  Future<Map<String, dynamic>> _updateCarFavoriteOnServer(int carId, bool isFavorite) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': carId,
          'favoritable_type': 'Car_Rental_Car',
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Updated successfully'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Update failed'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server.'
      };
    }
  }





}