import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/reserveAirlineCubit/reserveAirlineState.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:gaagls/model/airline.dart';
import 'package:gaagls/model/airlineSeats.dart';
import 'package:gaagls/model/airlineflights.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../model/tripStop.dart';
import '../../../model/tripStopSeats.dart';

class AirlineReserveCubit extends Cubit<AirlineReserveState> {
  AirlineReserveCubit() : super(const AirlineReserveState());



  Future<void> fetchAirlinePriceDetails({
    required Airlineflights airlineFlight,
    required AirLineSeats airlineSeat,
    required int capacity,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true));
    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/bill/${airlineFlight.id}/${airlineSeat.id}/$capacity'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final body = jsonDecode(response.body);
      print('📥 تفاصيل السعر: $body');

      print('price statusCode : ${response.statusCode}');

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



  Future<String?> reserveAirline({
    required Airlineflights airlineFlight,
    required AirLineSeats airlineSeat,
    required int capacity,
    required String paymentWay,
    required BuildContext context,
  }) async {
    emit(state.copyWith(isLoading: true));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.post(
        Uri.parse('${Globals().ngrok}/api/user/flight/booking/${airlineFlight.id}/${airlineSeat.id}/$capacity/$paymentWay'),
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
          selectedAirlineFlight: null,
          selectedAirlineSeats: null,
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
      capacities: [],
      airLineSeats: [],
      selectedAirlineFlight: null,
      selectedAirlineSeats: null,
      selectedCapacity: null,
      selectedPaymentMethod: null,
      tripPriceDetails: null,
      successMessage: null,
      errorMessage: null,

    ));
  }




  void selectPaymentMethod(String? method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }


  Future<void> fetchAirlineFlight({required int airlineId,required int destinationId}) async {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final token = await Globals().getToken() as String;

    try {
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/scheduled/flights/$airlineId/$destinationId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('fetchAirlineFlight statusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Airlineflights> airlineFlight = (data['flights'] as List)
            .map((e) => Airlineflights.fromJson(e))
            .toList();

        print(airlineFlight);

        emit(state.copyWith(airLineFlights: airlineFlight, isLoading: false));
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


  // void selectAirlineFlight(Airlineflights? airlineFlight) {
  //   if (airlineFlight == null) return;
  //   emit(state.copyWith(
  //     selectedAirlineFlight: airlineFlight,
  //     selectedAirlineSeats: null,
  //     airLineSeats: [],
  //     errorMessage: null,
  //   ));
  //   fetchAirlineSeats(flightId :airlineFlight.id);
  // }

  void selectAirlineFlight(Airlineflights? flight) {
    if (flight == null) return;
    emit(state.copyWith(
      selectedAirlineFlight: flight,
      selectedAirlineSeats: null,
      capacities: [],        // إعادة تهيئة السعات عند تغيير الرحلة
      errorMessage: null,
    ));
    fetchAirlineSeats(flightId: flight.id);
  }

  // Future<void> fetchAirlineSeats({required int flightId}) async {
  //   emit(state.copyWith(isLoading: true, errorMessage: null));
  //
  //   final token = await Globals().getToken() as String;
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${Globals().ngrok}/api/user/get/available/flight/seats/$flightId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print('fetchAirlineSeats statusCode: ${response.statusCode}');
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       List<AirLineSeats> airlineSeats = (data['flight_seats'] as List)
  //           .map((e) => AirLineSeats.fromJson(e))
  //           .toList();
  //
  //       emit(state.copyWith(airLineSeats: airlineSeats, isLoading: false));
  //     } else if (response.statusCode == 404) {
  //       String errorMessage = 'المقاعد غير موجودة';
  //       try {
  //         final data = json.decode(response.body);
  //         if (data['message'] != null) {
  //           errorMessage = data['message'];
  //         }
  //       } catch (_) {}
  //
  //       emit(state.copyWith(isLoading: false, errorMessage: errorMessage));
  //     } else {
  //       emit(state.copyWith(isLoading: false, errorMessage: 'فشل في تحميل المقاعد'));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
  //   }
  // }


  Future<void> fetchAirlineSeats({ required int flightId }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final token = await Globals().getToken() as String;
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/available/flight/seats/$flightId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final seatsJson = data['flight_seats'] as List<dynamic>?;
        if (seatsJson == null) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: 'لا توجد مقاعد في الاستجابة',
          ));
          return;
        }
        final airlineSeats = seatsJson
            .map((e) => AirLineSeats.fromJson(e))
            .toList();
        emit(state.copyWith(
          airLineSeats: airlineSeats,
          isLoading: false,
        ));
      } else if (response.statusCode == 404) {
        final body = json.decode(response.body);
        final msg = body['message'] ?? 'المقاعد غير موجودة';
        emit(state.copyWith(isLoading: false, errorMessage: msg));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'فشل في تحميل المقاعد (رمز ${response.statusCode})',
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }


  // void selectAirlineSeat(AirLineSeats? airlineSeat, int tripId,airlineflightId) {
  //   if (airlineSeat == null) return;
  //   emit(state.copyWith(
  //     selectedAirlineSeats: airlineSeat,
  //     errorMessage: null,
  //   ));
  //   fetchCapacities(
  //     flightId: tripId,
  //     airlineFlightId: airlineflightId,
  //     airlineSeatId: airlineSeat.id,
  //   );
  // }

  void selectAirlineSeat(AirLineSeats? seat) {
    if (seat == null) return;
    emit(state.copyWith(
      selectedAirlineSeats: seat,
      selectedCapacity: null,  // إعادة تهيئة العدد
      capacities: [],
      errorMessage: null,
    ));
    fetchCapacities(
      airlineSeatId: seat.id,
    );
  }

  // Future<void> fetchCapacities({
  //   required int airlineSeatId,
  // }) async {
  //   emit(state.copyWith(isLoading: true, errorMessage: null));
  //
  //   final token = await Globals().getToken() as String;
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse('${Globals().ngrok}/api/user/get/capacities/$airlineSeatId'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json',
  //       },
  //     );
  //
  //     print('num statusCode');
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       List<int> capacities = List<int>.from(data['valid_capacities'] ?? []);
  //
  //
  //
  //       print(capacities);
  //       print(data['message']);
  //
  //       if (data['valid_capacities'] != null) {
  //         emit(state.copyWith(
  //           capacities: capacities,
  //           isLoading: false,
  //           successMessage: data['message'],
  //         ));
  //       }
  //
  //
  //
  //       emit(state.copyWith(capacities: capacities, isLoading: false));
  //
  //     } else {
  //       emit(state.copyWith(isLoading: false, errorMessage: 'فشل في تحميل السعات'));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
  //   }
  // }

  Future<void> fetchCapacities({
    required int airlineSeatId,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      print(airlineSeatId);
      final token = await Globals().getToken() as String;
      final response = await http.get(
        Uri.parse('${Globals().ngrok}/api/user/get/capacities/$airlineSeatId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('fetchCapacities statusCode: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final capacities = List<int>.from(data['valid_capacities'] ?? []);
        print('🔢 fetched capacities = $capacities');
        emit(state.copyWith(
          capacities: capacities,
          isLoading: false,
          successMessage: data['message'],  // يمكنك استخدامه لاحقاً
        ));
      } else {
        // أي رمز حالة آخر، بما في ذلك 500
        final body = json.decode(response.body) as Map<String, dynamic>?;
        final serverMsg = body?['message'];
        emit(state.copyWith(
          isLoading: false,
          errorMessage:
          serverMsg != null
              ? serverMsg
              : 'خطأ في السيرفر (رمز ${response.statusCode})',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Exception: $e',
      ));
    }
  }


  void selectCapacity(int? capacity) {
    if (capacity == null) return;
    emit(state.copyWith(selectedCapacity: capacity, errorMessage: null));
  }



  // التحقق من الترتيب الصحيح للاختيارات
  String? validateSelectionOrder() {
    if (state.selectedAirlineFlight == null) return 'Please select the position first.';
    if (state.selectedAirlineSeats == null) return 'Please select the type of chair';
    if (state.selectedCapacity == null) return 'Please select the number of tickets';
    if (state.selectedPaymentMethod == null) return 'Please select the payment method';
    return null;
  }


}
