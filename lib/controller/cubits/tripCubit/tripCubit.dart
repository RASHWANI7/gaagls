import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsState.dart';
import 'package:gaagls/controller/cubits/tripCubit/tripState.dart';
import 'package:gaagls/model/resturant.dart';

import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/hotel.dart';
import '../../../model/trip.dart';

class TripsCubit extends Cubit<TripsState> {
  TripsCubit() : super(TripsInitial());

  List<Trip> tripsList = [];
  bool isTripFavoriteUpdating = false;

  Future<void> getTrips() async {
    emit(TripsLoading());

    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;
    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/onGoing/trips/$cityId'),
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

        tripsList.clear();

        if (jsonResponse['trips'] != null && jsonResponse['trips'] is List) {
          (jsonResponse['trips'] as List).forEach((v) {
            tripsList.add(Trip.fromJson(v));
          });
        }

        print(tripsList);
        print(tripsList.length);

        emit(TripsSuccess(
          trips: tripsList,
        ));
      } else {
        emit(TripsFailure(error: 'Failed To Load Data'));
      }
    } catch (e) {
      emit(TripsFailure(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>> toggleTripFavorite(Trip trip) async {
    // منع النقر المتكرر أو إذا الحالة ليست جاهزة
    if (isTripFavoriteUpdating || state is! TripsSuccess) {
      return {
        'success': false,
        'message': 'Please wait a moment before trying again.',
        'trip': trip,
      };
    }
    isTripFavoriteUpdating = true;

    final oldIsFav = trip.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as TripsSuccess;

    // تحديث محلي للـ state
    final updatedList = s.trips.map((t) {
      return t.tripId == trip.tripId ? t.copyWith(isFavorite: newIsFav) : t;
    }).toList();
    emit(s.copyWith(trips: updatedList));

    // إرسال إلى السيرفر
    final resp = await _updateTripFavoriteOnServer(trip.tripId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    // تراجع عند الفشل
    if (!success) {
      final revertedList = updatedList.map((t) {
        return t.tripId == trip.tripId ? t.copyWith(isFavorite: oldIsFav) : t;
      }).toList();
      emit(s.copyWith(trips: revertedList));
    }

    isTripFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'trip': success ? trip.copyWith(isFavorite: newIsFav) : trip,
    };
  }

  Future<Map<String, dynamic>> _updateTripFavoriteOnServer(
      int tripId, bool isFavorite) async {
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

  @override
  void onChange(Change<TripsState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);
  }
}
