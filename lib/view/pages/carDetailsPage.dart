import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/cubits/carDetailsCubit/carDetailsCubit.dart';
import '../../controller/cubits/carDetailsCubit/carDetailsState.dart';
import '../../controller/cubits/carScreenCubit/carScreenCubit.dart';
import '../../model/car.dart';
import '../widgets/secondSnackBar.dart';

class CarDetailsPage extends StatefulWidget {
  final List<Car> cars;
  final int initialIndex;
  final String companyName;

  const CarDetailsPage({
    super.key,
    required this.cars,
    required this.initialIndex,
    required this.companyName,
  });

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> with SingleTickerProviderStateMixin {
  late final CarDetailsCubit cubit;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final ValueNotifier<String?> _paymentMethodNotifier = ValueNotifier(
      'Credit Card');

  @override
  void initState() {
    super.initState();
    cubit = CarDetailsCubit(
        initialIndex: widget.initialIndex, carsLength: widget.cars.length);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    cubit.close();
    _controller.dispose();
    _paymentMethodNotifier.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart,
      int carIndex) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      if (isStart) {
        cubit.setStartDate(carIndex, picked);
      } else {
        cubit.setEndDate(carIndex, picked);
      }
    }
  }

  void _handleSlideAnimation(SlideDirection? direction) {
    if (direction == null) return;
    final begin = Offset(direction == SlideDirection.left ? 1.0 : -1.0, 0);
    _animation = Tween<Offset>(begin: begin, end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return BlocProvider.value(
      value: cubit,
      child: BlocListener<CarDetailsCubit, CarDetailsState>(
        listenWhen: (previous, current) =>
        previous.successBook != current.successBook ||
            previous.failureBook != current.failureBook,
        listener: (context, state) async {
          if (state.successBook) {
            MySnackBar(state.bookingMessage, context);
            context.read<CarDetailsCubit>().resetBookingState();
            await Future.delayed(const Duration(seconds: 2));
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } else if (state.failureBook) {
            Navigator.pop(context);
            MySnackBar(state.bookingMessage, context);
            context.read<CarDetailsCubit>().resetBookingState();
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(widget.companyName),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          body: BlocBuilder<CarDetailsCubit, CarDetailsState>(
            builder: (context, state) {
              _handleSlideAnimation(cubit.slideDirection);
              cubit.clearSlideDirection();

              final index = state.currentIndex;
              final car = widget.cars[index];
              final shop = car.carRentalShop;
              final startDate = state.startDates[index];
              final endDate = state.endDates[index];

              final totalDays = (startDate != null && endDate != null)
                  ? (endDate.isBefore(startDate) ? -1 : endDate
                  .difference(startDate)
                  .inDays + 1)
                  : 0;
              final totalPrice = totalDays > 0
                  ? totalDays * car.pricePerDay
                  : 0;

              Widget carCard(int idx, {bool isSide = false}) {
                final c = widget.cars[idx];
                return Container(
                  width: isSide ? 130 : MediaQuery
                      .of(context)
                      .size
                      .width * 0.85,
                  margin: EdgeInsets.symmetric(horizontal: isSide ? 8 : 0),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color:   Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 4),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 6))
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18)),
                              child: CachedNetworkImage(
                                imageUrl: c.image,
                                width: double.infinity,
                                height: isSide ? 90 : 180,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Container(
                                      width: double.infinity,
                                      height: isSide ? 90 : 180,
                                      color: Colors.grey[300],
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                      width: double.infinity,
                                      height: isSide ? 90 : 180,
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image),
                                    ),
                              ),
                            ),


                            Positioned(
                              top: 7,
                              right: 7,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.white.withOpacity(0.8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 30,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 300),
                                        transitionBuilder: (child, animation) =>
                                            ScaleTransition(scale: animation, child: child),
                                        child: Icon(
                                          car.isFavorite ? Icons.favorite : Icons.favorite_border,
                                          key: ValueKey(car.isFavorite),
                                          color: car.isFavorite ? Colors.redAccent : Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                      onPressed: () async {
                                        final result = await context.read<CarsCubit>().toggleCarFavorite(car);
                                        SecondSnackBar(
                                          result['message'],
                                          context,
                                          isError: !result['success'],
                                        );
                                      },
                                      splashRadius: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: c.status.toLowerCase() == 'available'
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  c.status,
                                  style: const TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Text(
                          "${c.brand} ${c.model}",
                          style: GoogleFonts.cairo(
                            fontSize: isSide ? 14 : 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        RatingBarIndicator(
                          rating: c.rating.toDouble(),
                          itemBuilder: (context, _) =>
                          const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 24,
                          direction: Axis.horizontal,
                        ),
                        if (!isSide) ...[
                          _infoRow(Icons.store, "Rental Shop", shop.name),
                          _infoRow(
                              Icons.location_on, "Location", shop.location),
                          _infoRow(Icons.calendar_month, "Year", c.year),
                          _infoRow(
                              Icons.settings, "Transmission", c.transmission),
                          _infoRow(Icons.event_seat, "Seats", "${c.seats}"),
                          _infoRow(Icons.attach_money, "Daily Rate",
                              "${c.pricePerDay.toStringAsFixed(2)} \$"),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _dateButton("Start Date", startDate, () =>
                                  _selectDate(context, true, index)),
                              _dateButton("End Date", endDate, () =>
                                  _selectDate(context, false, index)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            totalDays < 0
                                ? "Total: Invalid"
                                : "Total: ${totalPrice.toStringAsFixed(2)} \$",
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: totalDays < 0 ? Colors.red : Colors
                                  .green,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor, // اللون الأساسي
                              foregroundColor: Colors.white, // لون النص أو الأيقونة
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16), // شكل الزر
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                            ),
                            onPressed: totalDays > 0 &&
                                startDate != null &&
                                endDate != null &&
                                !(state.isBooked[index] ?? false)
                                ? () => _showConfirmDialog(
                                context, car, startDate, endDate)
                                : null,
                            child: const Text("Confirm Booking",style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.95,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.9,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (index > 0)
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                            onTap: () => cubit.changeIndex(index - 1, false),
                            child: carCard(index - 1, isSide: true),
                          ),
                        ),
                      if (index < widget.cars.length - 1)
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () => cubit.changeIndex(index + 1, true),
                            child: carCard(index + 1, isSide: true),
                          ),
                        ),
                      SlideTransition(
                        position: _animation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            carCard(index),
                            if (index > 0)
                              Positioned(
                                left: 8,
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.25,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Theme.of(context).primaryColor,),
                                  onPressed: () =>
                                      cubit.changeIndex(index - 1, false),
                                ),
                              ),
                            if (index < widget.cars.length - 1)
                              Positioned(
                                right: 8,
                                top: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.25,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      color: Theme.of(context).primaryColor),
                                  onPressed: () =>
                                      cubit.changeIndex(index + 1, true),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }




  void _showConfirmDialog(BuildContext context, Car car, DateTime startDate, DateTime endDate) {
    final cubit = context.read<CarDetailsCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<CarDetailsCubit, CarDetailsState>(
            builder: (context, state) {
              final isLoading = state.isLoading;

              return WillPopScope(
                onWillPop: () async => !isLoading,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Theme.of(context).cardColor,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  title: Center(
                    child: Column(
                      children: [
                        Text(
                          "Confirm Your Booking",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          "Choose your booking option:",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  content: ValueListenableBuilder<String?>(
                    valueListenable: _paymentMethodNotifier,
                    builder: (context, paymentMethod, _) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Theme.of(context).colorScheme.secondary),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: paymentMethod,
                            isExpanded: true,
                            iconEnabledColor: Theme.of(context).iconTheme.color,
                            items: const [
                              DropdownMenuItem(value: 'Credit Card', child: Text('Credit Card')),
                              DropdownMenuItem(value: 'Paypal', child: Text('Paypal')),
                            ],
                            onChanged: isLoading ? null : (val) {
                              _paymentMethodNotifier.value = val;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  actionsPadding: const EdgeInsets.only(top: 20, right: 12, left: 12, bottom: 12),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isLoading ? null : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Theme.of(context).colorScheme.secondary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text("Cancel", style: TextStyle(color: Theme.of(context).iconTheme.color)),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading || _paymentMethodNotifier.value == null
                                ? null
                                : () async {
                              final formattedStart = DateFormat('yyyy-MM-dd').format(startDate);
                              final formattedEnd = DateFormat('yyyy-MM-dd').format(endDate);
                              await cubit.confirmBooking(
                                carId: car.carId,
                                startDate: formattedStart,
                                endDate: formattedEnd,
                                paymentMethod: _paymentMethodNotifier.value!,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: isLoading
                                ? SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Theme.of(context).colorScheme.onPrimary
                              ),
                            )
                                : Text("Confirm", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }



// دوال المساعدة:
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$label: $value",
              style: GoogleFonts.cairo(fontSize: 15,
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateButton(String label, DateTime? date, VoidCallback onTap) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.cairo(fontWeight: FontWeight.w600,color: Theme.of(context).iconTheme.color),),
        TextButton(
          onPressed: onTap,
          child: Text(date != null
              ? DateFormat('yyyy-MM-dd').format(date)
              : "Select Date",
              style: GoogleFonts.cairo(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary)),
        ),
      ],
    );
  }
}