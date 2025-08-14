import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaagls/controller/cubits/EditBookingCubit/editBookingCubit.dart';
import 'package:gaagls/controller/cubits/EditBookingCubit/editBookingState.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import '../../model/bookingType.dart';
import '../../model/carRentalBooking.dart';
import '../../model/flightBooking.dart';
import '../../model/restaurantBooking.dart';
import '../../model/roomBooking.dart';
import '../../model/tripBooking.dart';


//
// class BookingDetailsPage extends StatelessWidget {
//   final BookingItem bookingItem;
//
//   const BookingDetailsPage({super.key, required this.bookingItem});
//
//   @override
//   Widget build(BuildContext context) {
//     final bool canCancel = _getStatus() == 'confirm';
//     final bool canRate = _getStatus() == 'completed' && _getRating() == 0;
//     final List<Widget> details = _buildDetails();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking Details"),
//         backgroundColor: Colors.blue.shade700,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           elevation: 10,
//           color: Colors.blue.shade50,
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     'Booking Invoice',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue.shade800,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ...details,
//                 const Divider(thickness: 1.5),
//                 const SizedBox(height: 16),
//                 if (canCancel)
//                   _buildCancelButton(context),
//                 if (canRate)
//                   _buildRatingSection(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCancelButton(BuildContext context) {
//     return Center(
//       child: ElevatedButton.icon(
//         icon: const Icon(Icons.cancel, size: 20),
//         label: const Text('Cancel Booking'),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red.shade600,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         onPressed: () {
//           // TODO: إلغاء الحجز
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Booking cancellation triggered!')),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildRatingSection(BuildContext context) {
//     double ratingValue = 3.0;
//
//     return Column(
//       children: [
//         const SizedBox(height: 16),
//         const Text(
//           "Rate Your Booking",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         RatingBar.builder(
//           initialRating: ratingValue,
//           minRating: 1,
//           direction: Axis.horizontal,
//           allowHalfRating: false,
//           itemCount: 5,
//           itemSize: 35,
//           unratedColor: Colors.grey.shade300,
//           itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
//           onRatingUpdate: (rating) {
//             ratingValue = rating;
//             // TODO: إرسال التقييم للسيرفر
//           },
//         ),
//         const SizedBox(height: 12),
//         ElevatedButton(
//           onPressed: () {
//             // TODO: إرسال التقييم للسيرفر
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Thank you for rating: ${ratingValue.toInt()} stars!')),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Text("Submit Rating", style: TextStyle(fontSize: 16)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> _buildDetails() {
//     final Map<String, String> data = {};
//
//     switch (bookingItem.type) {
//       case BookingType.room:
//         final b = bookingItem.booking as RoomBooking;
//         data.addAll({
//           'Booking Type': 'Room',
//           'Room ID': '${b.roomId}',
//           'Check-In': b.checkIn,
//           'Check-Out': b.checkOut,
//           'Payment Method': b.paymentMethod,
//           'Payment Status': b.paymentStatus,
//           'Status': b.status,
//           'Total Price': '${b.totalPrice} SAR',
//           'Booking Code': b.bookingCode,
//           'Created At': b.createdAt,
//           if (b.cancelReason != null && b.cancelReason!.isNotEmpty)
//             'Cancel Reason': b.cancelReason!,
//         });
//         break;
//
//       case BookingType.carRental:
//         final b = bookingItem.booking as CarRentalBooking;
//         data.addAll({
//           'Booking Type': 'Car Rental',
//           'Car ID': '${b.carRentalCarId}',
//           'Start': b.start,
//           'End': b.end,
//           'Payment Method': b.paymentMethod,
//           'Payment Status': b.paymentStatus,
//           'Status': b.status,
//           'Total Price': '${b.totalPrice} SAR',
//           'Booking Code': b.bookingCode,
//           'Created At': b.createdAt,
//         });
//         break;
//
//       case BookingType.flight:
//         final b = bookingItem.booking as FlightBooking;
//         data.addAll({
//           'Booking Type': 'Flight',
//           'Flight ID': '${b.flightId}',
//           'Tickets': '${b.numberOfTickets}',
//           'Payment Method': b.paymentMethod,
//           'Payment Status': b.paymentStatus,
//           'Status': b.status,
//           'Total Price': '${b.totalPrice} SAR',
//           'Booking Code': b.bookingCode,
//           'Created At': b.createdAt,
//           if (b.cancelReason != null && b.cancelReason!.isNotEmpty)
//             'Cancel Reason': b.cancelReason!,
//         });
//         break;
//
//       case BookingType.trip:
//         final b = bookingItem.booking as TripBooking;
//         data.addAll({
//           'Booking Type': 'Trip',
//           'Trip ID': '${b.tripId}',
//           'Tickets': '${b.numberOfTickets}',
//           'Payment Method': b.paymentMethod,
//           'Payment Status': b.paymentStatus,
//           'Status': b.status,
//           'Total Price': '${b.totalPrice} SAR',
//           'Booking Code': b.bookingCode,
//           'Created At': b.createdAt,
//         });
//         break;
//
//       case BookingType.restaurant:
//         final b = bookingItem.booking as RestaurantBooking;
//         data.addAll({
//           'Booking Type': 'Restaurant',
//           'Restaurant ID': '${b.restaurantId}',
//           'Seats': '${b.numberOfSeats}',
//           'Date': b.date,
//           'Start': b.start,
//           'End': b.end,
//           'Location': b.location,
//           'Status': b.status,
//           'Booking Code': b.bookingCode,
//           'Created At': b.createdAt,
//         });
//         break;
//     }
//
//     return data.entries.map((entry) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 6),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Icon(Icons.label_outline, color: Colors.blue, size: 20),
//             const SizedBox(width: 10),
//             Text(
//               "${entry.key}: ",
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//             Expanded(
//               child: Text(
//                 entry.value,
//                 style: const TextStyle(fontSize: 15),
//               ),
//             ),
//           ],
//         ),
//       );
//     }).toList();
//   }
//
//   String _getStatus() {
//     switch (bookingItem.type) {
//       case BookingType.room:
//         return (bookingItem.booking as RoomBooking).status;
//       case BookingType.carRental:
//         return (bookingItem.booking as CarRentalBooking).status;
//       case BookingType.flight:
//         return (bookingItem.booking as FlightBooking).status;
//       case BookingType.trip:
//         return (bookingItem.booking as TripBooking).status;
//       case BookingType.restaurant:
//         return (bookingItem.booking as RestaurantBooking).status;
//     }
//   }
//
//   int _getRating() {
//     switch (bookingItem.type) {
//       case BookingType.room:
//         return (bookingItem.booking as RoomBooking).rating;
//       case BookingType.carRental:
//         return (bookingItem.booking as CarRentalBooking).rating;
//       case BookingType.flight:
//         return (bookingItem.booking as FlightBooking).rating;
//       case BookingType.trip:
//         return (bookingItem.booking as TripBooking).rating;
//       case BookingType.restaurant:
//         return (bookingItem.booking as RestaurantBooking).rating;
//     }
//   }
// }



class BookingDetailsPage extends StatefulWidget {
  final BookingItem bookingItem;

  const BookingDetailsPage({super.key, required this.bookingItem});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {

  final ValueNotifier<double> _ratingValue = ValueNotifier(0.0);


  bool get _canCancel => _getStatus() == 'confirm';
  bool get _canRate => _getStatus() == 'completed' && _getRating() == 0;

  @override
  void initState() {
    super.initState();
    // تهيئة قيمة التقييم من الكائن الأصلي
    _ratingValue.value = _getRating().toDouble();
  }


  void _showRatingDialog() {
    final ValueNotifier<double> tempRating = ValueNotifier(3.0);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            final isLoading = context.read<Editbookingcubit>().state is EditbookingLoading;
            return !isLoading; // لا يمكن الرجوع إذا كان التحميل جاريًا
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Theme.of(context).cardColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            title: Center(
              child: Column(
                children: [
                  Text(
                    "How was your experience?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<double>(
                    valueListenable: tempRating,
                    builder: (_, rating, __) {
                      final emoji = _getEmoji(rating);
                      final label = _getRatingLabel(rating);
                      return Column(
                        children: [
                          Text(emoji, style: const TextStyle(fontSize: 50)),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).iconTheme.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            content: RatingBar.builder(
              initialRating: tempRating.value,
              minRating: 1,
              maxRating: 5,
              itemSize: 45,
              direction: Axis.horizontal,
              allowHalfRating: false,
              glow: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 6),
              itemBuilder: (context, _) => const Icon(Icons.star_rounded, color: Colors.amber),
              onRatingUpdate: (rating) {
                tempRating.value = rating;
              },
            ),
            actionsPadding: const EdgeInsets.only(top: 20, right: 12, left: 12, bottom: 12),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              BlocConsumer<Editbookingcubit, Editbookingstate>(
                listener: (context, state) {
                  if (state is EditbookingLoaded) {
                    Navigator.pop(context); // إغلاق Dialog
                    Navigator.pop(context, true); // الرجوع للصفحة السابقة
                    _ratingValue.value = tempRating.value; // تحديث التقييم المعروض
                    MySnackBar(state.message, context); // إظهار رسالة النجاح
                  } else if (state is EditbookingError) {
                    MySnackBar(state.message, context);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is EditbookingLoading;

                  return Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading ? null : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Theme.of(context).colorScheme.secondary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            final int id = getBookingId();
                            final String type = _getType();
                            context.read<Editbookingcubit>().rateBooking(
                              type: type,
                              id: id,
                              rating: tempRating.value.toInt(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: isLoading
                              ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text("Submit", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }




  void showCancelConfirmationDialog({
    required BuildContext context,
    required int bookingId,
    required String bookingType,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            final isLoading = context.read<Editbookingcubit>().state is EditbookingLoading;
            return !isLoading;
          },
          child: BlocConsumer<Editbookingcubit, Editbookingstate>(
            listener: (context, state) {
              if (state is EditbookingLoaded) {
                Navigator.pop(context);
                Navigator.pop(context, true);
                MySnackBar(state.message, context);
              } else if (state is EditbookingError) {
                MySnackBar(state.message, context);
              }
            },
            builder: (context, state) {
              final isLoading = state is EditbookingLoading;

              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: Theme.of(context).cardColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                title: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
                    const SizedBox(width: 10),
                    Text(
                      "Cancel Booking",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 18, // Bigger font
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Are you sure you want to cancel this booking?\nThis action cannot be undone.",
                    style: TextStyle(fontSize: 16.5, color: Theme.of(context).iconTheme.color), // Slightly bigger
                    textAlign: TextAlign.center,
                  ),
                ),
                actionsPadding: const EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 20),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: isLoading ? null : () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Theme.of(context).colorScheme.secondary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            "No",
                            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 120,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            context.read<Editbookingcubit>().cancelBooking(
                              id: bookingId,
                              type: bookingType,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: isLoading
                              ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Yes",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    final details = _buildDetails();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [Theme.of(context).cardColor, Theme.of(context).secondaryHeaderColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Booking Invoice',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ...details,
              Divider(
                thickness: 2,
                height: 40,
                color: Theme.of(context).colorScheme.secondary,
              ),
              if (_canCancel)
                _buildCancelButton(context),
              if (_canRate)
                ValueListenableBuilder<double>(
                  valueListenable: _ratingValue,
                  builder: (context, value, _) {
                    if (value > 0) return const SizedBox(); // التقييم تم
                    return Center(
                      child: ElevatedButton.icon(
                        onPressed: _showRatingDialog,
                        icon: const Icon(Icons.star_rate),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: Text(
                            'Rate Booking',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade700,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          elevation: 10,
                          shadowColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                        ),
                      ),
                    );
                  },
                ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.cancel_outlined, size: 22),
        label: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Cancel Booking',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 10,
          shadowColor: Colors.red.shade700,
          padding: const EdgeInsets.symmetric(horizontal: 35),
        ),
        onPressed: () {
            showCancelConfirmationDialog(
              context: context,
              bookingId: getBookingId(),
              bookingType: _getType(),
            );

        },
      ),
    );
  }

  List<Widget> _buildDetails() {
    final Map<String, String> data = {};

    switch (widget.bookingItem.type) {
      case BookingType.room:
        final b = widget.bookingItem.booking as RoomBooking;
        data.addAll({
          'Booking Type': 'Room',
          'Room ID': '${b.roomId}',
          'Check-In': b.checkIn,
          'Check-Out': b.checkOut,
          'Payment Method': b.paymentMethod,
          'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Total Price': '${b.totalPrice} \$',
          'Your Rate': '${b.rating} ⭐',
          'Booking Code': b.bookingCode,
          'Created At': b.createdAt,
          if (b.cancelReason != null && b.cancelReason!.isNotEmpty)
            'Cancel Reason': b.cancelReason!,
        });
        break;

      case BookingType.carRental:
        final b = widget.bookingItem.booking as CarRentalBooking;
        data.addAll({
          'Booking Type': 'Car Rental',
          'Car ID': '${b.carRentalCarId}',
          'Start': b.start,
          'End': b.end,
          'Payment Method': b.paymentMethod,
          'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Total Price': '${b.totalPrice} \$',
          'Your Rate': '${b.rating} ⭐',
          'Booking Code': b.bookingCode,
          'Created At': b.createdAt,
        });
        break;

      case BookingType.flight:
        final b = widget.bookingItem.booking as FlightBooking;
        data.addAll({
          'Booking Type': 'Flight',
          'Flight ID': '${b.flightId}',
          'Tickets': '${b.numberOfTickets}',
          'Payment Method': b.paymentMethod,
          'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Total Price': '${b.totalPrice} \$',
          'Your Rate': '${b.rating} ⭐',
          'Booking Code': b.bookingCode,
          'Created At': b.createdAt,
          if (b.cancelReason != null && b.cancelReason!.isNotEmpty)
            'Cancel Reason': b.cancelReason!,
        });
        break;

      case BookingType.trip:
        final b = widget.bookingItem.booking as TripBooking;
        data.addAll({
          'Booking Type': 'Trip',
          'Trip ID': '${b.tripId}',
          'Tickets': '${b.numberOfTickets}',
          'Payment Method': b.paymentMethod,
          'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Total Price': '${b.totalPrice} \$',
          'Your Rate': '${b.rating} ⭐',
          'Booking Code': b.bookingCode,
          'Created At': b.createdAt,
        });
        break;

      case BookingType.restaurant:
        final b = widget.bookingItem.booking as RestaurantBooking;
        data.addAll({
          'Booking Type': 'Restaurant',
          'Restaurant ID': '${b.restaurantId}',
          'Seats': '${b.numberOfSeats}',
          'Date': b.date,
          'Start': b.start,
          'End': b.end,
          'Location': b.location,
          'Status': b.status,
          'Your Rate': '${b.rating} ⭐',
          'Booking Code': b.bookingCode,
          'Created At': b.createdAt,
        });
        break;
    }

    return data.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.label_important_outline, color: Theme.of(context).colorScheme.secondary, size: 22),
            const SizedBox(width: 12),
            Text(
              "${entry.key}: ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Expanded(
              child: Text(
                entry.value,
                style: TextStyle(fontSize: 16, height: 1.3,color: Theme.of(context).iconTheme.color),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  String _getStatus() {
    switch (widget.bookingItem.type) {
      case BookingType.room:
        return (widget.bookingItem.booking as RoomBooking).status;
      case BookingType.carRental:
        return (widget.bookingItem.booking as CarRentalBooking).status;
      case BookingType.flight:
        return (widget.bookingItem.booking as FlightBooking).status;
      case BookingType.trip:
        return (widget.bookingItem.booking as TripBooking).status;
      case BookingType.restaurant:
        return (widget.bookingItem.booking as RestaurantBooking).status;
    }
  }

  int _getRating() {
    switch (widget.bookingItem.type) {
      case BookingType.room:
        return (widget.bookingItem.booking as RoomBooking).rating;
      case BookingType.carRental:
        return (widget.bookingItem.booking as CarRentalBooking).rating;
      case BookingType.flight:
        return (widget.bookingItem.booking as FlightBooking).rating;
      case BookingType.trip:
        return (widget.bookingItem.booking as TripBooking).rating;
      case BookingType.restaurant:
        return (widget.bookingItem.booking as RestaurantBooking).rating;
    }
  }

  int getBookingId() {
    switch (widget.bookingItem.type) {
      case BookingType.room:
        return (widget.bookingItem.booking as RoomBooking).id;
      case BookingType.carRental:
        return (widget.bookingItem.booking as CarRentalBooking).id;
      case BookingType.flight:
        return (widget.bookingItem.booking as FlightBooking).id;
      case BookingType.trip:
        return (widget.bookingItem.booking as TripBooking).id;
      case BookingType.restaurant:
        return (widget.bookingItem.booking as RestaurantBooking).id;
    }
  }

  String _getType() {
    switch (widget.bookingItem.type) {
      case BookingType.room:
        return 'room_booking';
      case BookingType.carRental:
        return 'car_rental';
      case BookingType.flight:
        return 'flight_booking';
      case BookingType.trip:
        return 'trip_booking';
      case BookingType.restaurant:
        return 'restaurant_booking';
    }
  }


  String _getRatingLabel(double rating) {
    if (rating >= 5) return "Excellent!";
    if (rating >= 4) return "Very Good";
    if (rating >= 3) return "Good";
    if (rating >= 2) return "Could be better";
    return "Bad";
  }

  String _getEmoji(double rating) {
    if (rating >= 5) return "😍";
    if (rating >= 4) return "😊";
    if (rating >= 3) return "🙂";
    if (rating >= 2) return "😐";
    return "😕";
  }



}

