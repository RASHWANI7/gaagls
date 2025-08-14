import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:http/http.dart' as http;
import '../../../model/destination.dart';
import '../../../model/homeData.dart';
import '../../../model/hotel.dart';
import '../../../model/resturant.dart';
import '../../../model/trip.dart';
import '../../../view/widgets/secondSnackBar.dart';
import 'homeState.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(isLoading: true)) {
    //loadHomeData();
  }

  Future<void> loadHomeData() async {
    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;

    try {
      emit(state.copyWith(isLoading: true));

      if (token == null || cityId == null) {
        emit(state.copyWith(error: 'بيانات المستخدم ناقصة'));
        return;
      }


      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/home/page/$cityId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      print(token);
      print(cityId);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final homeData = HomeData.fromJson(jsonData);
        print(homeData);
        emit(state.copyWith(data: homeData, isLoading: false));
      } else if (response.statusCode == 401) {
        final String message = jsonDecode(response.body)['message'];
        print(message);
      }
      else {
        emit(state.copyWith(error: 'فشل في تحميل البيانات', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }




  /*   restaurant favorite */
  ///////////////////////////////////////////////////////////////////////////


  bool isFavoriteUpdating = false;  // <-- هذا المتغير لتتبع حالة التحديث

  Future<Map<String, dynamic>> toggleRestaurantFavorite(Resturant restaurant) async {
    if (state.data == null || isFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
      };
    }
    isFavoriteUpdating = true;

    try {
      final currentData = state.data!;
      final oldIsFavorite = restaurant.isFavorite;

      // تحديث محلي مؤقت
      final updatedRestaurants = currentData.restaurants.map((r) {
        if (r.resturantId == restaurant.resturantId) {
          return r.copyWith(isFavorite: !r.isFavorite);
        }
        return r;
      }).toList();

      emit(state.copyWith(
        data: currentData.copyWith(restaurants: updatedRestaurants),
      ));

      // طلب للسيرفر
      final response = await _updateFavoriteOnServer(
        restaurant.resturantId,
        !oldIsFavorite,
      );

      final success = response['success'];
      final message = response['message'];

      if (!success) {
        // التراجع عند الفشل
        final revertedRestaurants = currentData.restaurants.map((r) {
          if (r.resturantId == restaurant.resturantId) {
            return r.copyWith(isFavorite: oldIsFavorite);
          }
          return r;
        }).toList();

        emit(state.copyWith(
          data: currentData.copyWith(restaurants: revertedRestaurants),
        ));
      }

      return {'success': success, 'message': message};
    } finally {
      isFavoriteUpdating = false; // ✅ إعادة التفعيل دائماً
    }
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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }



/*   hotel favorite */
////////////////////////////////////////////////////////////////////////////


  bool isHotelFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleHotelFavorite(Hotel hotel) async {
    if (state.data == null || isHotelFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
      };
    }

    isHotelFavoriteUpdating = true;

    try {
      final currentData = state.data!;
      final oldIsFavorite = hotel.isFavorite;

      // تحديث محلي مؤقت
      final updatedHotels = currentData.hotels.map((h) {
        if (h.hotelId == hotel.hotelId) {
          return h.copyWith(isFavorite: !h.isFavorite);
        }
        return h;
      }).toList();

      emit(state.copyWith(
        data: currentData.copyWith(hotels: updatedHotels),
      ));

      // طلب للسيرفر
      final response = await _updateHotelFavoriteOnServer(
        hotel.hotelId,
        !oldIsFavorite,
      );

      final success = response['success'];
      final message = response['message'];

      if (!success) {
        // التراجع عند الفشل
        final revertedHotels = currentData.hotels.map((h) {
          if (h.hotelId == hotel.hotelId) {
            return h.copyWith(isFavorite: oldIsFavorite);
          }
          return h;
        }).toList();

        emit(state.copyWith(
          data: currentData.copyWith(hotels: revertedHotels),
        ));
      }

      return {'success': success, 'message': message};
    } finally {
      isHotelFavoriteUpdating = false;
    }
  }


  Future<Map<String, dynamic>> _updateHotelFavoriteOnServer(int hotelId, bool isFavorite) async {
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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }




  /*   trip favorite */
  //////////////////////////////////////////////////////////////////////

  bool isTripFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleTripFavorite(Trip trip) async {
    if (state.data == null || isTripFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
      };
    }

    isTripFavoriteUpdating = true;

    try {
      final currentData = state.data!;
      final oldIsFavorite = trip.isFavorite;

      final updatedTrips = currentData.trips.map((t) {
        if (t.tripId == trip.tripId) {
          return t.copyWith(isFavorite: !t.isFavorite);
        }
        return t;
      }).toList();

      emit(state.copyWith(
        data: currentData.copyWith(trips: updatedTrips),
      ));

      final response = await _updateTripFavoriteOnServer(
        trip.tripId,
        !oldIsFavorite,
      );

      final success = response['success'];
      final message = response['message'];

      if (!success) {
        final revertedTrips = currentData.trips.map((t) {
          if (t.tripId == trip.tripId) {
            return t.copyWith(isFavorite: oldIsFavorite);
          }
          return t;
        }).toList();

        emit(state.copyWith(
          data: currentData.copyWith(trips: revertedTrips),
        ));
      }

      return {'success': success, 'message': message};
    } finally {
      isTripFavoriteUpdating = false;
    }
  }


  Future<Map<String, dynamic>> _updateTripFavoriteOnServer(int tripId, bool isFavorite) async {
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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network..',
      };
    }
  }



  /*   destination favorite */
  /////////////////////////////////////////////////////////////////////////

  bool isDestinationFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleDestinationFavorite(Destination destination) async {
    if (state.data == null || isDestinationFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
      };
    }

    isDestinationFavoriteUpdating = true;

    try {
      final currentData = state.data!;
      final oldIsFavorite = destination.isFavorite;

      final updatedDestinations = currentData.destinations.map((d) {
        if (d.destinationId == destination.destinationId) {
          return d.copyWith(isFavorite: !d.isFavorite);
        }
        return d;
      }).toList();

      emit(state.copyWith(
        data: currentData.copyWith(destinations: updatedDestinations),
      ));

      final response = await _updateDestinationFavoriteOnServer(
        destination.destinationId,
        !oldIsFavorite,
      );

      final success = response['success'];
      final message = response['message'];

      if (!success) {
        final revertedDestinations = currentData.destinations.map((d) {
          if (d.destinationId == destination.destinationId) {
            return d.copyWith(isFavorite: oldIsFavorite);
          }
          return d;
        }).toList();

        emit(state.copyWith(
          data: currentData.copyWith(destinations: revertedDestinations),
        ));
      }

      return {'success': success, 'message': message};
    } finally {
      isDestinationFavoriteUpdating = false;
    }
  }

  Future<Map<String, dynamic>> _updateDestinationFavoriteOnServer(int destinationId, bool isFavorite) async {
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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Updated successfully',
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Update failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to server. Check your network.',
      };
    }
  }





  @override
  void onChange(Change<HomeState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);
  }

}