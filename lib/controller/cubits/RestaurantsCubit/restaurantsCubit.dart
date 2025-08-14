import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsState.dart';
import 'package:gaagls/model/resturant.dart';

import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/hotel.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit() : super(RestaurantsInitial());

  List<Resturant> restaurantsList = [];
  bool isRestaurantFavoriteUpdating = false;


  Future<void> getRestaurants() async {
    emit(RestaurantsLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int ;
    try {

      final response = await http.get(Uri.parse('${Globals().ngrok}/api/user/get/restaurants/$cityId'),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(token);
      print(cityId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);



        // ✂️ أفرغ القائمة قبل التعبئة:
        restaurantsList.clear();

        if (jsonResponse['restaurants'] != null &&
            jsonResponse['restaurants'] is List) {
          (jsonResponse['restaurants'] as List).forEach((v) {
            restaurantsList.add(Resturant.fromJson(v));
          });
        }
        print(restaurantsList);
        print(restaurantsList.length);

        emit(RestaurantsSuccess(
          restaurants: restaurantsList,
        ));

      } else {
        emit( RestaurantsFailure(error: 'Failed To Load Data') );
      }
    } catch (e) {
      emit(RestaurantsFailure(error: e.toString()));
    }
  }


  Future<void> bookingRestaurant({required String date,required String startTime,required String endTime,required int numOfSeats,required String location,required int restaurantId}) async {
    emit(RestaurantsLoading());

    final  token = await Globals().getToken() as String;
    final  cityId = await Globals().getCityId() as int ;
    try {

      final response = await http.post(Uri.parse('${Globals().ngrok}/api/user/restaurant/booking/$cityId/$restaurantId'),
        body: jsonEncode({
          'date': date,
          'start': startTime,
          'end': endTime,
          'number_of_seats': numOfSeats,
          'location': location,
        }),
        headers: {
          'Authorization' : 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);
      print(token);
      print(cityId);

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        final message = jsonDecode(response.body)['message'];

        emit(RestaurantsBookingSuccess(message: message));

      }else if(response.statusCode==422){
        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(RestaurantsBookingFailure(message: message));
      }else if(response.statusCode== 404){
        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(RestaurantsBookingFailure(message: message));
      }else if(response.statusCode==400){
        final message = jsonDecode(response.body)['message'];
        print(message);
        emit(RestaurantsBookingFailure(message: message));
      }
      else {
        emit( RestaurantsBookingFailure(message: 'Please Try Again') );
      }
    } catch (e) {
      emit(RestaurantsBookingFailure(message: e.toString()));
    }
  }


    /*  restaurant favorite */
   /////////////////////////////////////////////////////////////////




  Future<Map<String, dynamic>> toggleRestaurantFavorite(Resturant restaurant) async {
    // منع التكرار أو العمل إن لم تكن القائمة جاهزة
    if (isRestaurantFavoriteUpdating || state is! RestaurantsSuccess) {
      return {
        'success': false,
        'message': 'الرجاء الانتظار قليلاً قبل المحاولة مرة أخرى.',
        'restaurant': restaurant,
      };
    }
    isRestaurantFavoriteUpdating = true;

    final oldIsFav = restaurant.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as RestaurantsSuccess;

    // 1️⃣ تحديث محلي لقائمة الـ state
    final updatedList = s.restaurants.map((r) {
      return r.resturantId == restaurant.resturantId
          ? r.copyWith(isFavorite: newIsFav)
          : r;
    }).toList();
    emit(s.copyWith(restaurants: updatedList));

    // 2️⃣ أرسل التغيير للسيرفر
    final resp = await _updateFavoriteOnServer(restaurant.resturantId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    // 3️⃣ لو فشل: عدّل العنصر لحالته القديمة
    if (!success) {
      final revertedList = updatedList.map((r) {
        return r.resturantId == restaurant.resturantId
            ? r.copyWith(isFavorite: oldIsFav)
            : r;
      }).toList();
      emit(s.copyWith(restaurants: revertedList));
    }

    isRestaurantFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'restaurant': success
          ? restaurant.copyWith(isFavorite: newIsFav)
          : restaurant,
    };
  }

  Future<Map<String, dynamic>> _updateFavoriteOnServer(int restaurantId, bool isFavorite) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': restaurantId,
          'favoritable_type': 'Restaurant',
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {'success': true, 'message': data['message'] ?? 'تم التحديث بنجاح'};
      } else {
        return {'success': false, 'message': data['message'] ?? 'فشل في التحديث'};
      }
    } catch (e) {
      return {'success': false, 'message': 'فشل الاتصال بالخادم. تأكد من الشبكة.'};
    }
  }






  @override
  void onChange(Change<RestaurantsState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);

  }

}

