//
// import 'dart:convert';
//
// import 'package:gaagls/model/carBrand.dart';
// import 'package:gaagls/model/destination.dart';
// import 'package:http/http.dart'as http;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gaagls/controller/cubits/searchCubit/searchState.dart';
//
// import '../../../globals/globals.dart';
// import '../../../model/airline.dart';
// import '../../../model/car.dart';
// import '../../../model/hotel.dart';
// import '../../../model/resturant.dart';
// import '../../../model/trip.dart';
//
// class SearchCubit extends Cubit<SearchState> {
//   SearchCubit() : super(SearchState.initial());
//
//   Future<void> fetchSearchResults(String query) async {
//     emit(state.copyWith(isLoading: true));
//
//     final cityId = await Globals().getCityId() as int;
//
//     try {
//       final response = await http.get(
//         Uri.parse('${Globals().ngrok}/api/user/search/$cityId?search=$query'),
//         headers: {
//           'Authorization': 'Bearer ${await Globals().getToken()}',
//         },
//       );
//       print(response.statusCode);
//
//       final data = jsonDecode(response.body);
//       print('search cars : ' + data['cars']);
//       print('search hotels : ' +data['hotels']);
//       print('search resturants : ' +data['restaurants']);
//       print('search trips : ' +data['trips']);
//       print('search destinations : ' +data['destinations']);
//
//       emit(state.copyWith(
//         carBrands: List<CarBrand>.from(data['cars'].map((e) => CarBrand.fromJson(e))),
//         hotels: List<Hotel>.from(data['hotels'].map((e) => Hotel.fromJson(e))),
//         restaurants: List<Resturant>.from(data['restaurants'].map((e) => Resturant.fromJson(e))),
//         trips: List<Trip>.from(data['trips'].map((e) => Trip.fromJson(e))),
//         destinations: List<Destination>.from(data['destinations'].map((e) => Destination.fromJson(e))),
//         isLoading: false,
//       ));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, error: 'حدث خطأ أثناء البحث.'));
//     }
//   }
//
//   void changeFilter(String filter) {
//     emit(state.copyWith(selectedFilter: filter));
//   }
// }



import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:gaagls/model/carBrand.dart';
import 'package:gaagls/model/hotel.dart';
import 'package:gaagls/model/resturant.dart';
import 'package:gaagls/model/trip.dart';
import 'package:gaagls/model/destination.dart';
import 'package:gaagls/controller/cubits/searchCubit/searchState.dart';
import '../../../globals/globals.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());

  Future<void> fetchSearchResults(String query) async {
    emit(state.copyWith(isLoading: true, error: '', hasSearched: true));

    final cityId = await Globals().getCityId() as int;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/search/$cityId?search=$query'),
        headers: {
          'Authorization': 'Bearer ${await Globals().getToken()}',
        },
      );
      print('🔄 statusCode: ${response.statusCode}');

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // طباعة القوائم للتأكد
      print('search cars       : ${data['cars']}');
      print('search hotels     : ${data['hotels']}');
      print('search restaurants: ${data['restaurants']}');
      print('search trips      : ${data['trips']}');
      print('search destinations: ${data['destinations']}');

      final carsList = List<CarBrand>.from(
        (data['cars'] as List).map((e) => CarBrand.fromJson(e)),
      );
      final hotelsList = List<Hotel>.from(
        (data['hotels'] as List).map((e) => Hotel.fromJson(e)),
      );
      final restList = List<Resturant>.from(
        (data['restaurants'] as List).map((e) => Resturant.fromJson(e)),
      );
      final tripsList = List<Trip>.from(
        (data['trips'] as List).map((e) => Trip.fromJson(e)),
      );
      final destList = List<Destination>.from(
        (data['destinations'] as List).map((e) => Destination.fromJson(e)),
      );


      // بعد تحضير القوائم:
      final Map<String, List> allLists = {
        'cars': carsList,
        'hotels': hotelsList,
        'restaurants': restList,
        'trips': tripsList,
        'destinations': destList,
      };

// ابحث عن القوائم غير الفارغة
      final nonEmpty = allLists.entries.where((e) => e.value.isNotEmpty)
          .toList();

// الفلتر الافتراضي
      String autoFilter = 'all';

// إذا كانت هناك قائمة واحدة فقط تحتوي على بيانات، استخدم مفتاحها كفلتر
      if (nonEmpty.length == 1) {
        autoFilter = nonEmpty.first.key;
      }


      emit(state.copyWith(
        carBrands: carsList,
        hotels: hotelsList,
        restaurants: restList,
        trips: tripsList,
        destinations: destList,
        isLoading: false,
        selectedFilter: autoFilter,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false,
          error: 'Failed to connect to server. Check your network.'));
    }
  }

  void changeFilter(String filter) {
    emit(state.copyWith(selectedFilter: filter));
  }

////////////////////////////////////////////////////////////////////


  Future<Map<String, dynamic>> _updateFavoriteOnServer(int id,
      String type) async {
    final token = await Globals().getToken() as String;
    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favoritable_id': id,
          'favoritable_type': type,
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


  bool isHotelFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleHotelFavoriteInSearch(Hotel hotel) async {
    if (isHotelFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'item': hotel,
      };
    }

    isHotelFavoriteUpdating = true;

    final oldFav = hotel.isFavorite;
    final newFav = !oldFav;

    final updatedList = state.hotels.map((h) {
      return h.hotelId == hotel.hotelId ? h.copyWith(isFavorite: newFav) : h;
    }).toList();

    emit(state.copyWith(hotels: updatedList));

    final resp = await _updateFavoriteOnServer(hotel.hotelId, 'Hotel');
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (!success) {
      // revert
      final reverted = updatedList.map((h) {
        return h.hotelId == hotel.hotelId ? h.copyWith(isFavorite: oldFav) : h;
      }).toList();
      emit(state.copyWith(hotels: reverted));
    }

    isHotelFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'item': success ? hotel.copyWith(isFavorite: newFav) : hotel,
    };
  }


  bool isRestaurantFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleRestaurantFavoriteInSearch(
      Resturant restaurant) async {
    if (isRestaurantFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'item': restaurant,
      };
    }

    isRestaurantFavoriteUpdating = true;

    final oldFav = restaurant.isFavorite;
    final newFav = !oldFav;

    final updatedList = state.restaurants.map((r) {
      return r.resturantId == restaurant.resturantId
          ? r.copyWith(isFavorite: newFav)
          : r;
    }).toList();

    emit(state.copyWith(restaurants: updatedList));

    final resp = await _updateFavoriteOnServer(
        restaurant.resturantId, 'Restaurant');
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (!success) {
      final reverted = updatedList.map((r) {
        return r.resturantId == restaurant.resturantId
            ? r.copyWith(isFavorite: oldFav)
            : r;
      }).toList();
      emit(state.copyWith(restaurants: reverted));
    }

    isRestaurantFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'item': success ? restaurant.copyWith(isFavorite: newFav) : restaurant,
    };
  }


  bool isTripFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleTripFavoriteInSearch(Trip trip) async {
    if (isTripFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'item': trip,
      };
    }

    isTripFavoriteUpdating = true;

    final oldFav = trip.isFavorite;
    final newFav = !oldFav;

    final updatedList = state.trips.map((t) {
      return t.tripId == trip.tripId ? t.copyWith(isFavorite: newFav) : t;
    }).toList();

    emit(state.copyWith(trips: updatedList));

    final resp = await _updateFavoriteOnServer(trip.tripId, 'Trip');
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    if (!success) {
      final reverted = updatedList.map((t) {
        return t.tripId == trip.tripId ? t.copyWith(isFavorite: oldFav) : t;
      }).toList();
      emit(state.copyWith(trips: reverted));
    }

    isTripFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'item': success ? trip.copyWith(isFavorite: newFav) : trip,
    };
  }


  bool isDestinationFavoriteUpdating = false;

  Future<Map<String, dynamic>> toggleDestinationFavoriteInSearch(
      Destination destination) async {
    if (isDestinationFavoriteUpdating) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'item': destination,
      };
    }

    isDestinationFavoriteUpdating = true;

    final oldFav = destination.isFavorite;
    final newFav = !oldFav;

    final updatedList = state.destinations.map((d) {
      return d.destinationId == destination.destinationId
          ? d.copyWith(isFavorite: newFav)
          : d;
    }).toList();

    emit(state.copyWith(destinations: updatedList));

    final resp = await _updateFavoriteOnServer(
        destination.destinationId, 'City');
    final success = resp['success'] as bool;
    final message = resp['message'] as String;


    if (!success) {
      final reverted = updatedList.map((d) {
        return d.destinationId == destination.destinationId
            ? d.copyWith(isFavorite: oldFav)
            : d;
      }).toList();
      emit(state.copyWith(destinations: reverted));
    }

    isDestinationFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'item': success ? destination.copyWith(isFavorite: newFav) : destination,
    };
  }

}
