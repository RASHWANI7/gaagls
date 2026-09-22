import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/bookingCubit/bookingCubit.dart';
import 'package:remixicon/remixicon.dart';
import '../../model/bookingType.dart';
import '../../model/roomBooking.dart';

import '../../model/flightBooking.dart';
import '../../model/tripBooking.dart';
import '../../model/carRentalBooking.dart';
import '../../model/restaurantBooking.dart';
import '../pages/bookingDetailsPage.dart';


class BookingItemCard extends StatelessWidget {
  final BookingItem bookingItem;

  const BookingItemCard({super.key, required this.bookingItem});

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    late String title;
    late Map<String, dynamic> fields;

    switch (bookingItem.type) {
      case BookingType.room:
        final b = bookingItem.booking as RoomBooking;
        icon = RemixIcons.hotel_line;
        title = 'Room Booking #${b.roomId}';
        fields = {
         // 'Check-In': b.checkIn,
         // 'Check-Out': b.checkOut,
         // 'Payment Method': b.paymentMethod,
         // 'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Booking Code': b.bookingCode,
          'Total Price': '${b.totalPrice} \$',
          if (b.cancelReason != null && b.cancelReason!.isNotEmpty) 'Cancellation Reason': b.cancelReason!,
          'Created At': b.createdAt,
        };
        break;

      case BookingType.carRental:
        final b = bookingItem.booking as CarRentalBooking;
        icon = RemixIcons.car_line;
        title = 'Car Rental #${b.carRentalCarId}';
        fields = {
          // 'Start': b.start,
          // 'End': b.end,
          // 'Payment Method': b.paymentMethod,
          // 'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Booking Code': b.bookingCode,
          'Total Price': '${b.totalPrice} \$',
          'Created At': b.createdAt,
        };
        break;

      case BookingType.flight:
        final b = bookingItem.booking as FlightBooking;
        icon = RemixIcons.plane_line;
        title = 'Flight #${b.flightId}';
        fields = {
          // 'Tickets': '${b.numberOfTickets}',
          // 'Payment Method': b.paymentMethod,
          // 'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Booking Code': b.bookingCode,
          'Total Price': '${b.totalPrice} \$',
          if (b.cancelReason != null && b.cancelReason!.isNotEmpty) 'Cancellation Reason': b.cancelReason!,
          'Created At': b.createdAt,
        };
        break;

      case BookingType.trip:
        final b = bookingItem.booking as TripBooking;
        icon = RemixIcons.map_line;
        title = 'Trip #${b.tripId}';
        fields = {
          // 'Tickets': '${b.numberOfTickets}',
          // 'Payment Method': b.paymentMethod,
          // 'Payment Status': b.paymentStatus,
          'Status': b.status,
          'Booking Code': b.bookingCode,
          'Total Price': '${b.totalPrice} \$',
          'Created At': b.createdAt,
        };
        break;

      case BookingType.restaurant:
        final b = bookingItem.booking as RestaurantBooking;
        icon = RemixIcons.restaurant_line;
        title = 'Restaurant #${b.restaurantId}';
        fields = {
          'Seats': '${b.numberOfSeats}',
          // 'Date': b.date,
          // 'Start': b.start,
          // 'End': b.end,
          // 'Location': b.location,
          'Status': b.status,
          'Booking Code': b.bookingCode,
          'Created At': b.createdAt,
        };
        break;
    }

    return InkWell(
      onTap: () async{
        final shouldRefresh = await
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingDetailsPage(bookingItem: bookingItem),
          ),
        );
        if (shouldRefresh == true) {
          context.read<BookingsCubit>().loadBookings(); // ✅ أعد تحميل البيانات
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleRow(icon, title,context),
              const SizedBox(height: 14),
              ..._buildFieldList(fields,context),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Created on: ${fields['Created At']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleRow(IconData icon, String title,BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 30),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFieldList(Map<String, dynamic> fields,BuildContext context) {
    return fields.entries
        .where((entry) => entry.key != 'Created At' && entry.value.toString().isNotEmpty)
        .map((entry) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_getIconForLabel(entry.key), color: Theme.of(context).colorScheme.secondary, size: 22),
          const SizedBox(width: 10),
          Text(
            '${entry.key}: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Theme.of(context).iconTheme.color
            ),
          ),
          Expanded(
            child: Text(
              entry.value.toString(),
              style: TextStyle(fontSize: 16,color: Theme.of(context).iconTheme.color),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ))
        .toList();
  }

  IconData _getIconForLabel(String label) {
    final lower = label.toLowerCase();
    if (lower.contains('date') || lower.contains('check') || lower.contains('start')) return Icons.date_range;
    if (lower.contains('end')) return Icons.logout;
    if (lower.contains('status')) return Icons.verified;
    if (lower.contains('method')) return Icons.payment;
    if (lower.contains('code')) return Icons.confirmation_number;
    if (lower.contains('price') || lower.contains('total')) return Icons.monetization_on;
    if (lower.contains('rating')) return Icons.star;
    if (lower.contains('cancel')) return Icons.cancel;
    if (lower.contains('seat')) return Icons.event_seat;
    if (lower.contains('location')) return Icons.location_on;
    return Icons.info_outline;
  }
}
