

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/reserveTripCubit/reserveTripState.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../model/tripStop.dart';
import '../../../model/tripStopSeats.dart';

class TripReserveCubit extends Cubit<TripReserveState> {
  TripReserveCubit() : super(const TripReserveState());



  Future<void> fetchTripPriceDetails({
    required int tripId,
    required TripStop tripStop,
    required TripStopSeat tripstopseat,
    required String roomType,
    required int capacity,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true));
    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/bill/$tripId/${tripStop.tripId}/${tripstopseat.id}/$roomType/$capacity'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final body = jsonDecode(response.body);
      print('📥 تفاصيل السعر: $body');

      print('price statusCode');
      print(response.statusCode);

      if (response.statusCode == 200) {
        emit(state.copyWith(
          tripPriceDetails: body,
          isLoading: false,
        ));
      } else {
        //MySnackBar('فشل في جلب تفاصيل السعر', context);
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print('❌ خطأ: $e');
      MySnackBar('حدث خطأ أثناء تحميل السعر.', context);
      emit(state.copyWith(isLoading: false));
    }
  }


  // Future<void> reserveTrip({
  //   required TripStop tripStop,
  //   required TripStopSeat tripstopseat,
  //   required String roomType,
  //   required int capacity,
  //   required String paymentWay,
  //   required int tripId,
  //   required BuildContext context, // نحتاج هذا لعرض MyDialog
  // }) async {
  //   emit(state.copyWith(isLoading: true));
  //
  //   final token = await Globals().getToken() as String;
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${Globals().ngrok}/api/user/trip/booking/$tripId/${tripStop.id}/${tripstopseat.id}/$roomType/$capacity/$paymentWay'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );
  //
  //     final responseBody = jsonDecode(response.body);
  //     print('🔁 كود الاستجابة: ${response.statusCode}');
  //     print('📦 البيانات المستلمة: $responseBody');
  //
  //     if (response.statusCode == 201) {
  //       // ✅ نجاح الحجز
  //
  //       MySnackBar(responseBody['message'], context);
  //
  //
  //
  //       emit(state.copyWith(
  //         selectedTripStop: null,
  //         selectedSeat: null,
  //         selectedType: null,
  //         selectedCapacity: null,
  //         selectedPaymentMethod: null,
  //         isLoading: false,
  //       ));
  //
  //
  //     } else if (response.statusCode == 404) {
  //       // ❌ رسالة خطأ من السيرفر
  //       MySnackBar(responseBody['message'], context);
  //       emit(state.copyWith(isLoading: false));
  //
  //     } else {
  //       throw Exception(responseBody['message'] ?? 'حدث خطأ غير متوقع');
  //
  //     }
  //   } catch (e) {
  //     print('❌ استثناء الحجز: $e');
  //     emit(state.copyWith(
  //       isLoading: false,
  //       errorMessage: 'فشل إرسال الحجز: $e',
  //     ));
  //     MySnackBar('حدث خطأ أثناء محاولة الحجز.', context);
  //
  //   }
  // }



  Future<String?> reserveTrip({
    required TripStop tripStop,
    required TripStopSeat tripstopseat,
    required String roomType,
    required int capacity,
    required String paymentWay,
    required int tripId,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/trip/booking/$tripId/${tripStop.id}/${tripstopseat.id}/$roomType/$capacity/$paymentWay'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseBody = jsonDecode(response.body);
      print('🔁 كود الاستجابة: ${response.statusCode}');
      print('📦 البيانات المستلمة: $responseBody');

      if (response.statusCode == 201) {
        // نجاح الحجز + حفظ رسالة النجاح في الحالة
        final successMsg = responseBody['message'] ?? "تم الحجز بنجاح!";
        emit(state.copyWith(
          selectedTripStop: null,
          selectedSeat: null,
          selectedType: null,
          selectedCapacity: null,
          selectedPaymentMethod: null,
          isLoading: false,
          successMessage: successMsg,
        ));

        return successMsg;
      } else if (response.statusCode == 404) {
        MySnackBar(responseBody['message'], context);
        emit(state.copyWith(isLoading: false));
        return null;
      } else {
        throw Exception(responseBody['message'] ?? 'حدث خطأ غير متوقع');
      }
    } catch (e) {
      print('❌ استثناء الحجز: $e');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'فشل إرسال الحجز: $e',
      ));
      MySnackBar('حدث خطأ أثناء محاولة الحجز.', context);
      return null;
    }
  }




  void resetSelection() {
    emit(state.copyWith(
      selectedTripStop: null,
      selectedSeat: null,
      selectedType: null,
      selectedCapacity: null,
      selectedPaymentMethod: null,
    ));
  }





  String? selectedPaymentMethod;

  void selectPaymentMethod(String? method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }


  Future<void> fetchTripStops(int tripId) async {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/trip/stops/$tripId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('fetchTripStops statusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<TripStop> stops = (data['trip_stops'] as List)
            .map((e) => TripStop.fromJson(e))
            .toList();

        emit(state.copyWith(tripStops: stops, isLoading: false));
      } else if (response.statusCode == 404) {
        // محاولة قراءة رسالة الخطأ من الـ body إذا موجودة
        String errorMessage = 'الموقف غير موجود';
        try {
          final data = json.decode(response.body);
          if (data['message'] != null) {
            errorMessage = data['message'];
          }
        } catch (_) {
          // تجاهل أي خطأ في التحليل
        }
        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'فشل في تحميل المواقف'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }


  void selectTripStop(TripStop? tripStop) {
    if (tripStop == null) return;
    emit(state.copyWith(
      selectedTripStop: tripStop,
      selectedSeat: null,
      selectedType: null,
      selectedCapacity: null,
      tripStopSeats: [],
      types_of_room: [],
      capacities: [],
      errorMessage: null,
    ));
    fetchTripStopSeats(tripStop.id);
  }


  Future<void> fetchTripStopSeats(int tripStopId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/trip/stop/seats/$tripStopId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('fetchTripStopSeats statusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<TripStopSeat> seats = (data['trip_stop_seats'] as List)
            .map((e) => TripStopSeat.fromJson(e))
            .toList();

        emit(state.copyWith(tripStopSeats: seats, isLoading: false));
      } else if (response.statusCode == 404) {
        String errorMessage = 'المقاعد غير موجودة';
        try {
          final data = json.decode(response.body);
          if (data['message'] != null) {
            errorMessage = data['message'];
          }
        } catch (_) {}

        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'فشل في تحميل المقاعد'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }


  void selectSeat(TripStopSeat? seat, int tripId) {
    if (seat == null) return;
    emit(state.copyWith(
      selectedSeat: seat,
      selectedType: null,
      selectedCapacity: null,
      types_of_room: [],
      capacities: [],
      errorMessage: null,
    ));
    fetchRoomTypes(tripId: tripId);
  }



  Future<void> fetchRoomTypes({required int tripId}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/room/types/$tripId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('fetchTypes statusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<String> types_of_room = List<String>.from(data['types'] ?? []);

        emit(state.copyWith(types_of_room: types_of_room, isLoading: false));
      } else if (response.statusCode == 404) {
        String errorMessage = 'الأنواع غير موجودة';
        try {
          final data = json.decode(response.body);
          if (data['message'] != null) {
            errorMessage = data['message'];
          }
        } catch (_) {}

        emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'فشل في تحميل الأنواع'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }


  void selectType(String? type, int tripId, int seatId) {
    if (type == null) return;
    emit(state.copyWith(
      selectedType: type,
      selectedCapacity: null,
      capacities: [],
      errorMessage: null,
    ));
    fetchCapacities(
      tripId: tripId,
      tripStopSeatId: seatId,
      roomType: type,
    );
  }

  Future<void> fetchCapacities({
    required int tripId,
    required int tripStopSeatId,
    required String roomType,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/capacities/$tripId/$tripStopSeatId/$roomType'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('num statusCode');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<int> capacities = List<int>.from(data['capacities'] ?? []);



        print(capacities);
        print(data['message']);

        if (data['message'] != null) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: data['message'], // أو successMessage
          ));
        }


        emit(state.copyWith(capacities: capacities, isLoading: false));

      } else {
        emit(state.copyWith(isLoading: false, errorMessage: 'فشل في تحميل السعات'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void selectCapacity(int? capacity) {
    if (capacity == null) return;
    emit(state.copyWith(selectedCapacity: capacity, errorMessage: null));
  }

  // التحقق من الترتيب الصحيح للاختيارات
  String? validateSelectionOrder() {
    if (state.selectedTripStop == null) return 'Please select the position first.';
    if (state.selectedSeat == null) return 'Please select the type of chair';
    if (state.selectedType == null) return 'Please select the type of room';
    if (state.selectedCapacity == null) return 'Please select the number of tickets';
    if (state.selectedPaymentMethod == null) return 'Please select the payment method';
    return null;
  }


}
