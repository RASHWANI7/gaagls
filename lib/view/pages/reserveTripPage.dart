// // import 'package:flutter/material.dart';
// //
// // class ReserveTripPage extends StatefulWidget {
// //   const ReserveTripPage({super.key});
// //
// //   @override
// //   State<ReserveTripPage> createState() => _ReserveTripPageState();
// // }
// //
// // class _ReserveTripPageState extends State<ReserveTripPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../controller/cubits/reserveTripCubit/reserveTripCubit.dart';
// import '../../controller/cubits/reserveTripCubit/reserveTripState.dart';
// import '../../model/trip.dart';
// import '../../model/tripStop.dart';
// import '../../model/tripStopSeats.dart';
//
// class TripReservePage extends StatelessWidget {
//
//   final Trip trip;
//   const TripReservePage({super.key,required this.trip});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) {
//         final cubit = TripReserveCubit();
//         cubit.fetchTripStops(trip.tripId);  // تمرير tripId هنا
//         return cubit;
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('حجز الرحلة')),
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: BlocConsumer<TripReserveCubit, TripReserveState>(
//             listener: (context, state) {
//               if (state.errorMessage != null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.errorMessage!)),
//                 );
//               }
//             },
//             builder: (context, state) {
//               final cubit = context.read<TripReserveCubit>();
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Dropdown 1 - Trip Stops
//                   DropdownButtonFormField<TripStop>(
//                     decoration: const InputDecoration(labelText: 'اختيار الموقف'),
//                     items: state.tripStops
//                         .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e.tripStopName),
//                     ))
//                         .toList(),
//                     value: state.selectedTripStop,
//                     onChanged: (value) => cubit.selectTripStop(value),
//                     hint: const Text('اختر موقفًا'),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Dropdown 2 - Seats (تعطيل إذا لم يتم اختيار الموقف)
//                   DropdownButtonFormField<TripStopSeat>(
//                     decoration: const InputDecoration(labelText: 'اختيار نوع الكرسي'),
//                     items: state.tripStopSeats
//                         .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e.seatType),
//                     ))
//                         .toList(),
//                     value: state.selectedSeat,
//                     onChanged: state.selectedTripStop == null ? null : (value) => cubit.selectSeat(value,trip.tripId),
//                     hint: const Text('اختر نوع الكرسي'),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Dropdown 3 - Types (تعطيل إذا لم يتم اختيار الكرسي أو القائمة فارغة)
//                   DropdownButtonFormField<String>(
//                     decoration: const InputDecoration(labelText: 'اختيار نوع الغرفة'),
//                     items: state.types
//                         .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e),
//                     ))
//                         .toList(),
//                     value: state.selectedType,
//                     onChanged: (state.selectedSeat == null || state.types.isEmpty)
//                         ? null
//                         : (value) => cubit.selectType(value,trip.tripId,state.selectedSeat!.id),
//                     hint: const Text('اختر نوع الغرفة'),
//                   ),
//                   const SizedBox(height: 16),
//
//                   // Dropdown 4 - Capacities (تعطيل إذا لم يتم اختيار النوع أو القائمة فارغة)
//                   DropdownButtonFormField<int>(
//                     decoration: const InputDecoration(labelText: 'اختيار عدد التذاكر'),
//                     items: state.capacities
//                         .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e.toString()),
//                     ))
//                         .toList(),
//                     value: state.selectedCapacity,
//                     onChanged: (state.selectedType == null || state.capacities.isEmpty)
//                         ? null
//                         : (value) => cubit.selectCapacity(value),
//                     hint: const Text('اختر عدد التذاكر'),
//                   ),
//                   const SizedBox(height: 24),
//
//                   ElevatedButton(
//                     onPressed: () {
//                       final validationError = cubit.validateSelectionOrder();
//                       if (validationError != null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text(validationError)),
//                         );
//                         return;
//                       }
//                       // نفذ الحجز أو الإجراء المطلوب هنا
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('تم اختيار جميع القيم بنجاح!')),
//                       );
//                     },
//                     child: const Text('تأكيد الحجز'),
//                   ),
//
//                   if (state.isLoading)
//                     const Padding(
//                       padding: EdgeInsets.only(top: 16),
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TripReservePage extends StatelessWidget {
//   final Trip trip;
//   const TripReservePage({super.key, required this.trip});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) {
//         final cubit = TripReserveCubit();
//         cubit.fetchTripStops(trip.tripId);
//         return cubit;
//       },
//       child: Scaffold(
//         appBar: AppBar(title: const Text('حجز الرحلة')),
//         body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: BlocConsumer<TripReserveCubit, TripReserveState>(
//                 listener: (context, state) {
//                   if (state.errorMessage != null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text(state.errorMessage!)),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   final cubit = context.read<TripReserveCubit>();
//
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const Text(
//                         'معلومات الحجز',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 24),
//
//                       // 🛑 Trip Stop Dropdown
//                       DropdownButtonFormField<TripStop>(
//                         decoration: const InputDecoration(labelText: 'اختيار الموقف'),
//                         items: state.tripStops.map((e) {
//                           return DropdownMenuItem(
//                             value: e,
//                             child: Text(e.tripStopName),
//                           );
//                         }).toList(),
//                         value: state.selectedTripStop,
//                         onChanged: (value) => cubit.selectTripStop(value),
//                         hint: const Text('اختر موقفًا'),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // 💺 Seat Dropdown
//                       DropdownButtonFormField<TripStopSeat>(
//                         decoration: const InputDecoration(labelText: 'اختيار نوع الكرسي'),
//                         items: state.tripStopSeats.map((e) {
//                           return DropdownMenuItem(
//                             value: e,
//                             child: Text(e.seatType),
//                           );
//                         }).toList(),
//                         value: state.selectedSeat,
//                         onChanged: state.selectedTripStop == null
//                             ? null
//                             : (value) => cubit.selectSeat(value, trip.tripId),
//                         hint: const Text('اختر نوع الكرسي'),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // 🏨 Room Type Dropdown
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(labelText: 'اختيار نوع الغرفة'),
//                         items: state.types.map((e) {
//                           return DropdownMenuItem(
//                             value: e,
//                             child: Text(e),
//                           );
//                         }).toList(),
//                         value: state.selectedType,
//                         onChanged: (state.selectedSeat == null || state.types.isEmpty)
//                             ? null
//                             : (value) => cubit.selectType(value, trip.tripId, state.selectedSeat!.id!),
//                         hint: const Text('اختر نوع الغرفة'),
//                       ),
//                       const SizedBox(height: 16),
//
//                       // 👥 Capacity Dropdown
//                       DropdownButtonFormField<int>(
//                         decoration: const InputDecoration(labelText: 'اختيار عدد التذاكر'),
//                         items: state.capacities.map((e) {
//                           return DropdownMenuItem(
//                             value: e,
//                             child: Text(e.toString()),
//                           );
//                         }).toList(),
//                         value: state.selectedCapacity,
//                         onChanged: (state.selectedType == null || state.capacities.isEmpty)
//                             ? null
//                             : (value) => cubit.selectCapacity(value),
//                         hint: const Text('اختر عدد التذاكر'),
//                       ),
//                       const SizedBox(height: 24),
//
//                       // ✅ Confirm Button
//                       if (!state.isLoading)
//                         ElevatedButton.icon(
//                           icon: const Icon(Icons.check_circle),
//                           onPressed: () {
//                             final validationError = cubit.validateSelectionOrder();
//                             if (validationError != null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text(validationError)),
//                               );
//                               return;
//                             }
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('تم اختيار جميع القيم بنجاح!')),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             textStyle: const TextStyle(fontSize: 16),
//                           ),
//                           label: const Text('تأكيد الحجز'),
//                         ),
//
//                       // 🔄 Loading Indicator
//                       if (state.isLoading)
//                         const Center(
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 16),
//                             child: CircularProgressIndicator(),
//                           ),
//                         ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//         backgroundColor: const Color(0xFFF4F4F4),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import '../../controller/cubits/reserveTripCubit/reserveTripCubit.dart';
import '../../controller/cubits/reserveTripCubit/reserveTripState.dart';
import '../../model/trip.dart';
import '../../model/tripStop.dart';
import '../../model/tripStopSeats.dart';


class TripReservePage extends StatelessWidget {
  final Trip trip;

  const TripReservePage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = TripReserveCubit();
        cubit.fetchTripStops(trip.tripId);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trip Booking',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).iconTheme.color)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color(0xFFE3F2FD),
                // Color(0xFFBBDEFB),
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).secondaryHeaderColor,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.96),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: BlocConsumer<TripReserveCubit, TripReserveState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      MySnackBar(state.errorMessage.toString(), context);
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<TripReserveCubit>();

                    return WillPopScope(
                      onWillPop: () async {
                        // لا تسمح بالرجوع إذا كان هناك تحميل
                        return !state.isLoading;
                      },
                      child: AbsorbPointer(
                        absorbing: state.isLoading,
                        child: Opacity(
                          opacity: state.isLoading ? 0.6 : 1.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Header with animation
                              Column(
                                children: [
                                  Text(
                                    'Booking Details',
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      letterSpacing: 0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Select your trip preferences',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).hintColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),

                              // Modern Dropdown Sections
                              _buildDropdownSection(
                                context: context,
                                title: 'Departure Point',
                                value: state.selectedTripStop?.tripStopName,
                                icon: Icons.location_pin,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: () => _showSelectionModal<TripStop>(
                                  context: context,
                                  title: 'Select Departure Point',
                                  items: state.tripStops,
                                  itemBuilder: (e) => e.tripStopName,
                                  onSelect: (value) => cubit.selectTripStop(value),
                                  selectionType: 'tripStop',
                                ),
                                isEnabled: state.tripStops.isNotEmpty,
                              ),

                              const SizedBox(height: 20),

                              _buildDropdownSection(
                                context: context,
                                title: 'Seat Type',
                                value: state.selectedSeat?.seatType,
                                icon: Icons.airline_seat_recline_extra,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: state.selectedTripStop == null
                                    ? null
                                    : () => _showSelectionModal<TripStopSeat>(
                                          context: context,
                                          title: 'Select Seat Type',
                                          items: state.tripStopSeats,
                                          itemBuilder: (e) => e.seatType,
                                          onSelect: (value) =>
                                              cubit.selectSeat(value, trip.tripId),
                                          selectionType: 'seatType',
                                        ),
                                isEnabled: state.selectedTripStop != null,
                              ),

                              const SizedBox(height: 20),

                              _buildDropdownSection(
                                context: context,
                                title: 'Room Type',
                                value: state.selectedType,
                                icon: Icons.king_bed,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: (state.selectedSeat == null ||
                                        state.types_of_room.isEmpty)
                                    ? null
                                    : () => _showSelectionModal<String>(
                                          context: context,
                                          title: 'Select Room Type',
                                          items: state.types_of_room,
                                          itemBuilder: (e) => e,
                                          onSelect: (value) => cubit.selectType(
                                              value,
                                              trip.tripId,
                                              state.selectedSeat!.id!),
                                          selectionType: 'roomType',
                                        ),
                                isEnabled: state.selectedSeat != null,
                              ),

                              const SizedBox(height: 20),

                              _buildDropdownSection(
                                context: context,
                                title: 'Number of Tickets',
                                value: state.selectedCapacity?.toString(),
                                icon: Icons.confirmation_number,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: (state.selectedType == null ||
                                        state.capacities.isEmpty)
                                    ? null
                                    : () => _showSelectionModal<int>(
                                          context: context,
                                          title: 'Select Ticket Quantity',
                                          items: state.capacities,
                                          itemBuilder: (e) => e.toString(),
                                          onSelect: (value) =>
                                              cubit.selectCapacity(value),
                                          selectionType: 'capacity',
                                        ),
                                isEnabled: state.selectedType != null,
                              ),

                              const SizedBox(height: 20),

                              _buildDropdownSection(
                                context: context,
                                title: 'Payment Method',
                                value: cubit.state.selectedPaymentMethod == null
                                    ? 'Select Payment Method'
                                    : cubit.state.selectedPaymentMethod == 'paypal'
                                        ? 'PayPal 💸'
                                        : 'Credit Card 💳',
                                icon: Icons.payment,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: () => _showSelectionModal<String>(
                                  context: context,
                                  title: 'Select Payment Method',
                                  items: const ['paypal', 'creditCard'],
                                  itemBuilder: (e) => e == 'paypal'
                                      ? 'PayPal 💸'
                                      : 'Credit Card 💳',
                                  onSelect: (value) =>
                                      cubit.selectPaymentMethod(value),
                                  selectionType: 'payment',
                                ),
                                isEnabled: true,
                              ),

                              const SizedBox(height: 30),

                              // Animated Confirm Button
                              if (!state.isLoading)
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.blue.shade700.withOpacity(0.4),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF1565C0),
                                        Color(0xFF0D47A1),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      HapticFeedback.mediumImpact();
                                      final validationError =
                                          cubit.validateSelectionOrder();
                                      if (validationError != null) {
                                        MySnackBar(validationError, context);
                                        return;
                                      }
                                      // تحديث الحالة إلى isLoading = true
                                      cubit.emit(state.copyWith(isLoading: true));

                                      // جلب تفاصيل الأسعار
                                      await cubit.fetchTripPriceDetails(
                                        tripId: trip.tripId,
                                        tripStop: state.selectedTripStop!,
                                        tripstopseat: state.selectedSeat!,
                                        roomType: state.selectedType!,
                                        capacity: state.selectedCapacity!,
                                        context: context,
                                      );

                                      final priceData =
                                          cubit.state.tripPriceDetails;

                                      if (priceData == null) {
                                        cubit
                                            .emit(state.copyWith(isLoading: false));
                                        MySnackBar(
                                            "فشل في تحميل تفاصيل الأسعار", context);
                                        return;
                                      }

                                      // عرض الفاتورة
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (dialogContext) {
                                          return BlocProvider.value(
                                            value: cubit,
                                            child: BlocBuilder<TripReserveCubit,
                                                TripReserveState>(
                                              builder: (context, state) {
                                                final isBooking = state.isLoading;
                                            
                                                if (isBooking) {
                                                  return WillPopScope(
                                                    onWillPop: () async => false, // يمنع الرجوع بزر الجهاز
                                                    child: AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20)),
                                                      content: const SizedBox(
                                                        height: 100,
                                                        child: Center(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              CircularProgressIndicator(),
                                                              SizedBox(height: 20),
                                                              Text(
                                                                  "Processing your booking..."),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                            
                                                final priceData =
                                                    state.tripPriceDetails!;
                                            
                                                return WillPopScope(
                                                  onWillPop: () async => false, // يمنع الرجوع بزر الجهاز
                                                  child: AlertDialog(
                                                    backgroundColor:
                                                    Theme.of(context).cardColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(20)),
                                                    titlePadding: const EdgeInsets.only(
                                                        top: 20, left: 20, right: 20),
                                                    contentPadding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    title: Row(
                                                      children: [
                                                        Icon(Icons.receipt_long_rounded,
                                                            color: Theme.of(context).colorScheme.secondary,
                                                            size: 28),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Booking Invoice',
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20,
                                                            color: Theme.of(context).colorScheme.secondary,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 8),
                                                        buildPriceRow("Trip Price",
                                                            "${priceData["trip_price"]} \$",context: context),
                                                        buildPriceRow(
                                                            "Total Trip Price",
                                                            "${priceData["trip_price_total"]} \$",context: context),
                                                        buildPriceRow("Seat Price",
                                                            "${priceData["trip_stop_seat_price"]} \$",context: context),
                                                        buildPriceRow(
                                                            "Total Seat Price",
                                                            "${priceData["trip_stop_seat_price_total"]} \$",context: context),
                                                        buildPriceRow(
                                                            "Room Price / Day",
                                                            "${priceData["room_price_per_day"]} \$",context: context),
                                                        buildPriceRow(
                                                            "Total Room Price",
                                                            "${priceData["room_price_total"]} \$",context: context),
                                                        const SizedBox(height: 12),
                                                        Divider(
                                                            color: Colors.grey.shade400,
                                                            thickness: 1.2),
                                                        const SizedBox(height: 8),
                                                        buildPriceRow("Grand Total",
                                                            "${priceData["total_price"]} \$",context: context,
                                                            bold: true,
                                                            color: Theme.of(context).iconTheme.color),
                                                      ],
                                                    ),
                                                    actionsPadding:
                                                        const EdgeInsets.only(
                                                            bottom: 12, right: 12),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(dialogContext)
                                                                .pop(),
                                                        child:  Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color: Theme.of(context).iconTheme.color),
                                                        ),
                                                      ),
                                                      ElevatedButton.icon(
                                                        onPressed: state.isLoading
                                                            ? null
                                                            : () async {
                                                                cubit.emit(
                                                                    state.copyWith(
                                                                        isLoading:
                                                                            true));

                                                                final successMsg =
                                                                    await cubit
                                                                        .reserveTrip(
                                                                  tripStop: state
                                                                      .selectedTripStop!,
                                                                  tripstopseat: state
                                                                      .selectedSeat!,
                                                                  roomType: state
                                                                      .selectedType!,
                                                                  capacity: state
                                                                      .selectedCapacity!,
                                                                  paymentWay: state
                                                                      .selectedPaymentMethod!,
                                                                  tripId: trip.tripId,
                                                                  context:
                                                                      dialogContext,
                                                                );

                                                                cubit.emit(
                                                                    state.copyWith(
                                                                        isLoading:
                                                                            false));

                                                                Navigator.of(
                                                                        dialogContext)
                                                                    .pop();

                                                                if (successMsg != null) {
                                                                  showDialog(
                                                                    context: context,
                                                                    barrierDismissible: false,
                                                                    builder: (ctx) =>
                                                                        WillPopScope(
                                                                          onWillPop: () async => false, // يمنع الرجوع بزر الجهاز
                                                                          child: AlertDialog(
                                                                                                                                                shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                        16)),
                                                                                                                                                title: const Text(
                                                                            "Booking Successful",
                                                                            style: TextStyle(
                                                                                fontWeight:
                                                                                    FontWeight
                                                                                        .bold)),
                                                                                                                                                content: Text(
                                                                            successMsg),
                                                                                                                                                actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(
                                                                                      ctx)
                                                                                  .pop();
                                                                              Navigator.of(
                                                                                      ctx)
                                                                                  .pop();
                                                                            },
                                                                            child: const Text(
                                                                                "OK"),
                                                                          ),
                                                                                                                                                ],
                                                                                                                                              ),
                                                                        ),
                                                                  );
                                                                } else {
                                                                  MySnackBar(
                                                                      "Booking failed. Please try again.",
                                                                      context);
                                                                }
                                                              },
                                                        icon: const Icon(
                                                            Icons.check_circle_outline,
                                                            size: 20,
                                                            color: Colors.white),
                                                        label: const Text(
                                                            "Confirm Booking",
                                                            style: TextStyle(
                                                                color: Colors.white)),
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                          Theme.of(context).colorScheme.secondary,
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 20,
                                                              vertical: 12),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      12)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },

                                    borderRadius: BorderRadius.circular(20),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: Colors.white, size: 28),
                                        SizedBox(width: 12),
                                        Text(
                                          'Reserve',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              if (state.isLoading)
                                Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: const Center(
                                        child: CircularProgressIndicator())),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modern Dropdown Item Widget
  Widget _buildDropdownSection({
    required BuildContext context,
    required String title,
    required String? value,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    required bool isEnabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Row(
            children: [
              Icon(icon, size: 20, color: color.withOpacity(0.8)),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? onTap : null,
            borderRadius: BorderRadius.circular(18),
            splashColor: color.withOpacity(0.1),
            highlightColor: color.withOpacity(0.05),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: isEnabled ? Theme.of(context).secondaryHeaderColor : Theme.of(context).iconTheme.color,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color:
                      isEnabled ? color.withOpacity(0.3) : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isEnabled ? color : Colors.grey.shade500,
                    size: 22,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      value ?? 'Select $title',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            value != null ? FontWeight.w600 : FontWeight.normal,
                        color: value != null
                            ? Theme.of(context).iconTheme.color
                            : Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: isEnabled ? color : Colors.grey.shade400,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSelectionModal<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required String Function(T) itemBuilder,
    required Function(T) onSelect,
    required String
        selectionType, // 🆕 النوع: 'tripStop', 'seatType', 'roomType', 'capacity', 'payment'
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // Modal Title
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            const Divider(height: 0, thickness: 1),
            // Item List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 20, thickness: 0.5),
                itemBuilder: (context, index) {
                  final item = items[index];

                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      onSelect(item);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildModalItemDetails(item: item,selectionType:  selectionType,context: context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalItemDetails({dynamic item,required String selectionType,required BuildContext context}) {
    final mainTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onSurface);
    final secondaryTextStyle = TextStyle(fontSize: 14, color: Theme.of(context).iconTheme.color);
    final cardDecoration = BoxDecoration(
      color: Theme.of(context).secondaryHeaderColor, // لون أزرق سماوي فاتح، مميز عن الأبيض
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.secondary, // ظل أقوى قليلاً (شفاف أسود)
          blurRadius: 20,
          spreadRadius: 4,
          offset: const Offset(0, 8), // ظل للأسفل
        ),
      ],
    );

    // Trip Stop (Departure Point)
    if (item is TripStop) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(item.tripStopName, style: mainTextStyle),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.schedule, size: 18, color: Theme.of(context).iconTheme.color),
                const SizedBox(width: 6),
                Text("Start: ${item.start}  •  End: ${item.end}",
                    style: secondaryTextStyle),
              ],
            ),
          ],
        ),
      );
    }

    // Seat Type
    else if (item is TripStopSeat) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: cardDecoration,
        child: Row(
          children: [
            Icon(Icons.airline_seat_recline_extra,
                color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.seatType, style: mainTextStyle),
                  const SizedBox(height: 4),
                   Text("Comfortable & spacious",
                      style: secondaryTextStyle),
                ],
              ),
            ),
            Text("${item.price} \$",
                style: mainTextStyle.copyWith(color: Colors.green[700])),
          ],
        ),
      );
    }

    // Number of Tickets
    else if (item is int && selectionType == 'capacity') {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: cardDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.confirmation_number, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 8),
            Text("$item Ticket${item > 1 ? 's' : ''}", style: mainTextStyle),
          ],
        ),
      );
    }

    // Room Type
    else if (item is String && selectionType == 'roomType') {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: cardDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.king_bed_rounded, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 10),
            Text(item, style: mainTextStyle),
          ],
        ),
      );
    }

    // Payment Method
    else if (item is String && selectionType == 'payment') {
      IconData icon =
          item == 'paypal' ? Icons.account_balance_wallet : Icons.credit_card;
      Color color = item == 'paypal' ? Colors.indigo : Colors.teal;
      String display = item == 'paypal' ? 'PayPal 💸' : 'Credit Card 💳';

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: cardDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Text(display, style: mainTextStyle),
          ],
        ),
      );
    }

    // Default fallback
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration,
      child: Center(
        child: Text(
          item.toString(),
          style: mainTextStyle,
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, String value,
      {bool bold = false, Color? color,required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).iconTheme.color,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color ?? Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
