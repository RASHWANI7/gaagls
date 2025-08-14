import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cubits/bookingCubit/bookingCubit.dart';
import '../../controller/cubits/bookingCubit/bookingState.dart';
import '../widgets/bookingItemCard.dart';

// افترض أن BookingsCubit و BookingsState و BookingItem و BookingType معرفين مسبقًا

class BookingsPage extends StatefulWidget {
  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BookingsCubit>().loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحجوزات'),
        centerTitle: true,
      ),
      body: BlocBuilder<BookingsCubit, BookingsState>(
        builder: (context, state) {
          if (state is BookingsInitial) {
            return const Center(child: Text('لا توجد بيانات'));
          } else if (state is BookingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingsLoaded) {

            final bookings = state.bookings;

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final bookingItem = bookings[index];
                return BookingItemCard(bookingItem: bookingItem);
              },
            );
          } else if (state is BookingsError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}



