import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/car.dart';
import '../../../model/destination.dart';
import '../../../model/hotel.dart';
import '../../../model/resturant.dart';
import '../../../model/trip.dart';
import 'favoriteState.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());


  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/favorites/$cityId'), // تأكد من الـ endpoint
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        // نفترض أن JSON به مفاتيح: cars, hotels, restaurants, trips, destinations
        final cars = (data['cars'] as List? ?? [])
            .map((e) => Car.fromJson(e as Map<String, dynamic>))
            .toList();
        final hotels = (data['hotels'] as List? ?? [])
            .map((e) => Hotel.fromJson(e as Map<String, dynamic>))
            .toList();
        final restaurants = (data['restaurants'] as List? ?? [])
            .map((e) => Resturant.fromJson(e as Map<String, dynamic>))
            .toList();
        final trips = (data['trips'] as List? ?? [])
            .map((e) => Trip.fromJson(e as Map<String, dynamic>))
            .toList();
        final destinations = (data['destinations'] as List? ?? [])
            .map((e) => Destination.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(FavoriteSuccess(
          cars: cars,
          hotels: hotels,
          restaurants: restaurants,
          trips: trips,
          destinations: destinations,
        ));
      } else {
        emit(FavoriteFailure(error: 'Failed to load favorites'));
      }
    } catch (e) {
      emit(FavoriteFailure(error: e.toString()));
    }
  }
//////////////////////////////////////////////////////////////////////////////////


  void changeFilter(String filter) {
    if (state is FavoriteSuccess) {
      final currentState = state as FavoriteSuccess;
      emit(currentState.copyWith(selectedFilter: filter));
    }
  }



  ////////////////////////////////////////////////////////////////////////

  bool isRestaurantFavoriteUpdating =false;

  Future<Map<String, dynamic>> toggleRestaurantFavorite(Resturant restaurant) async {
    // 1) إذا جارى تحديث أو لم نتمكن من العمل على الحالة الآن فانسحب
    if (isRestaurantFavoriteUpdating || state is! FavoriteSuccess) {
      return {
        'success': false,
        'message': 'الرجاء الانتظار قليلاً قبل المحاولة مرة أخرى.',
        'restaurant': restaurant,
      };
    }
    isRestaurantFavoriteUpdating = true;

    final oldIsFav = restaurant.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as FavoriteSuccess;

    // 2) نسخه محليًا مع تبديل isFavorite
    final updatedList = s.restaurants.map((r) {
      return r.resturantId == restaurant.resturantId
          ? r.copyWith(isFavorite: newIsFav)
          : r;
    }).toList();
    emit(s.copyWith(restaurants: updatedList));

    // 3) أرسل التحديث للسيرفر
    final resp = await _updateFavoriteOnServer(restaurant.resturantId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (success) {
      // إذا حُدِف من المفضَّلات (newIsFav == false) احذفه نهائيًا
      if (!newIsFav) {
        final filtered = updatedList
            .where((r) => r.resturantId != restaurant.resturantId)
            .toList();
        emit(s.copyWith(restaurants: filtered));
      }
      // إذا أُضيف (newIsFav == true) تبقى في القائمة مع isFavorite = true
    } else {
      // 4) عند الفشل عدّل العنصر لحالته القديمة
      final reverted = updatedList.map((r) {
        return r.resturantId == restaurant.resturantId
            ? r.copyWith(isFavorite: oldIsFav)
            : r;
      }).toList();
      emit(s.copyWith(restaurants: reverted));
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
        'message': 'Failed to connect to server. Check your network.'
      };
    }
  }


    ///////////////////////////////////////////////////////


  bool isHotelFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleHotelFavorite(Hotel hotel) async {
    if (isHotelFavoriteUpdating || state is! FavoriteSuccess) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'hotel': hotel,
      };
    }

    isHotelFavoriteUpdating = true;

    final oldIsFav = hotel.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as FavoriteSuccess;

    // تحديث محلي isFavorite
    final updatedList = s.hotels.map((h) {
      return h.hotelId == hotel.hotelId
          ? h.copyWith(isFavorite: newIsFav)
          : h;
    }).toList();
    emit(s.copyWith(hotels: updatedList));

    // طلب للسيرفر
    final resp = await _updateFavoriteHotelOnServer(hotel.hotelId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (success) {
      // عند الحذف الحقيقي، نحذفه من القائمة
      if (!newIsFav) {
        final filtered = updatedList
            .where((h) => h.hotelId != hotel.hotelId)
            .toList();
        emit(s.copyWith(hotels: filtered));
      }
    } else {
      // تراجع في حال الفشل
      final reverted = updatedList.map((h) {
        return h.hotelId == hotel.hotelId
            ? h.copyWith(isFavorite: oldIsFav)
            : h;
      }).toList();
      emit(s.copyWith(hotels: reverted));
    }

    isHotelFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'hotel': success
          ? hotel.copyWith(isFavorite: newIsFav)
          : hotel,
    };
  }

  Future<Map<String, dynamic>> _updateFavoriteHotelOnServer(int hotelId, bool isFavorite) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': hotelId,
          'favoritable_type': 'Hotel',
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }
///////////////////////////////////////////////////////////////////////

  bool isTripFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleTripFavorite(Trip trip) async {
    if (isTripFavoriteUpdating || state is! FavoriteSuccess) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'trip': trip,
      };
    }

    isTripFavoriteUpdating = true;

    final oldIsFav = trip.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as FavoriteSuccess;

    // تحديث محلي isFavorite
    final updatedList = s.trips.map((t) {
      return t.tripId == trip.tripId
          ? t.copyWith(isFavorite: newIsFav)
          : t;
    }).toList();
    emit(s.copyWith(trips: updatedList));

    // إرسال الطلب للسيرفر
    final resp = await _updateFavoriteTripOnServer(trip.tripId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (success) {
      if (!newIsFav) {
        final filtered = updatedList
            .where((t) => t.tripId != trip.tripId)
            .toList();
        emit(s.copyWith(trips: filtered));
      }
    } else {
      // التراجع عند الفشل
      final reverted = updatedList.map((t) {
        return t.tripId == trip.tripId
            ? t.copyWith(isFavorite: oldIsFav)
            : t;
      }).toList();
      emit(s.copyWith(trips: reverted));
    }

    isTripFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'trip': success
          ? trip.copyWith(isFavorite: newIsFav)
          : trip,
    };
  }

  Future<Map<String, dynamic>> _updateFavoriteTripOnServer(int tripId, bool isFavorite) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': tripId,
          'favoritable_type': 'Trip',
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }

  /////////////////////////////////////////////////////////////////////


  bool isCarFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleCarFavorite(Car car) async {
    if (isCarFavoriteUpdating || state is! FavoriteSuccess) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'car': car,
      };
    }

    isCarFavoriteUpdating = true;

    final oldIsFav = car.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as FavoriteSuccess;

    final updatedList = s.cars.map((c) {
      return c.carId == car.carId ? c.copyWith(isFavorite: newIsFav) : c;
    }).toList();
    emit(s.copyWith(cars: updatedList));

    final resp = await _updateFavoriteCarOnServer(car.carId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (success) {
      if (!newIsFav) {
        final filtered = updatedList.where((c) => c.carId != car.carId).toList();
        emit(s.copyWith(cars: filtered));
      }
    } else {
      final reverted = updatedList.map((c) {
        return c.carId == car.carId ? c.copyWith(isFavorite: oldIsFav) : c;
      }).toList();
      emit(s.copyWith(cars: reverted));
    }

    isCarFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'car': success ? car.copyWith(isFavorite: newIsFav) : car,
    };
  }

  Future<Map<String, dynamic>> _updateFavoriteCarOnServer(int carId, bool isFavorite) async {
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
          'message': data['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }
///////////////////////////////////////////////////////////////////


  bool isDestinationFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleDestinationFavorite(Destination destination) async {
    if (isDestinationFavoriteUpdating || state is! FavoriteSuccess) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'destination': destination,
      };
    }

    isDestinationFavoriteUpdating = true;

    final oldIsFav = destination.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as FavoriteSuccess;

    final updatedList = s.destinations.map((d) {
      return d.destinationId == destination.destinationId
          ? d.copyWith(isFavorite: newIsFav)
          : d;
    }).toList();
    emit(s.copyWith(destinations: updatedList));

    final resp = await _updateFavoriteDestinationOnServer(destination.destinationId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (success) {
      if (!newIsFav) {
        final filtered = updatedList
            .where((d) => d.destinationId != destination.destinationId)
            .toList();
        emit(s.copyWith(destinations: filtered));
      }
    } else {
      final reverted = updatedList.map((d) {
        return d.destinationId == destination.destinationId
            ? d.copyWith(isFavorite: oldIsFav)
            : d;
      }).toList();
      emit(s.copyWith(destinations: reverted));
    }

    isDestinationFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'destination': success
          ? destination.copyWith(isFavorite: newIsFav)
          : destination,
    };
  }

  Future<Map<String, dynamic>> _updateFavoriteDestinationOnServer(int destinationId, bool isFavorite) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': destinationId,
          'favoritable_type': 'City',
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }




}
