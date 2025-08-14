import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../globals/globals.dart';
import '../../../model/hotel.dart';
import 'hotelsState.dart';

class HotelsCubit extends Cubit<HotelsState> {
  HotelsCubit() : super(HotelsInitial());

  List<Hotel> hotelsList = [];
  bool isHotelFavoriteUpdating = false;

  Future<void> getHotels() async {
    emit(HotelsLoading());

    final token = await Globals().getToken() as String;
    final cityId = await Globals().getCityId() as int;
    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/hotel/$cityId'),
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

        // ✂️ أفرغ القائمة قبل التعبئة:
        hotelsList.clear();

        if (jsonResponse['hotels'] != null && jsonResponse['hotels'] is List) {
          (jsonResponse['hotels'] as List).forEach((v) {
            hotelsList.add(Hotel.fromJson(v));
          });
        }

        print(hotelsList);
        print(hotelsList.length);

        emit(HotelsSuccess(
          hotels: hotelsList,
        ));
      } else {
        emit(HotelsFailure(error: 'Failed To Load Data'));
      }
    } catch (e) {
      emit(HotelsFailure(error: e.toString()));
    }
  }

  Future<Map<String, dynamic>> toggleHotelFavorite(Hotel hotel) async {
    // 1️⃣ منع التكرار أو إذا لم تكن في حالة النجاح
    if (isHotelFavoriteUpdating || state is! HotelsSuccess) {
      return {
        'success': false,
        'message': 'الرجاء الانتظار قليلاً قبل المحاولة مرة أخرى.',
        'hotel': hotel,
      };
    }
    isHotelFavoriteUpdating = true;

    final oldIsFav = hotel.isFavorite;
    final newIsFav = !oldIsFav;
    final s = state as HotelsSuccess;

    // 2️⃣ تحديث محلي لقائمة الـ state
    final updatedList = s.hotels.map((h) {
      return h.hotelId == hotel.hotelId ? h.copyWith(isFavorite: newIsFav) : h;
    }).toList();
    emit(s.copyWith(hotels: updatedList));

    // 3️⃣ أرسل التغيير للسيرفر
    final resp = await _updateHotelFavoriteOnServer(hotel.hotelId, newIsFav);
    final success = resp['success'] as bool;
    final message = resp['message'] as String;

    // 4️⃣ إذا فشل، عدّل العنصر لحالته القديمة
    if (!success) {
      final revertedList = updatedList.map((h) {
        return h.hotelId == hotel.hotelId
            ? h.copyWith(isFavorite: oldIsFav)
            : h;
      }).toList();
      emit(s.copyWith(hotels: revertedList));
    }

    isHotelFavoriteUpdating = false;

    return {
      'success': success,
      'message': message,
      'hotel': success ? hotel.copyWith(isFavorite: newIsFav) : hotel,
    };
  }

  Future<Map<String, dynamic>> _updateHotelFavoriteOnServer(
      int hotelId, bool isFavorite) async {
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
          'message': data['message'] ?? 'تم التحديث بنجاح'
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'فشل في التحديث'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'فشل الاتصال بالخادم. تأكد من الشبكة.'
      };
    }
  }

  @override
  void onChange(Change<HotelsState> change) {
    // TODO: implement onChange
    print('State changed: $change');
    super.onChange(change);
  }
}
