import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/reserveAirlineCubit/reserveAirlineCubit.dart';
import 'package:gaagls/controller/cubits/reserveAirlineCubit/reserveAirlineState.dart';
import 'package:gaagls/model/airline.dart';
import 'package:gaagls/model/airlineSeats.dart';
import 'package:gaagls/model/airlineflights.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';



class ReserveAirlinePage extends StatelessWidget {
  final Airline airline;
  final int destinationId;

  const ReserveAirlinePage({super.key, required this.airline,required this.destinationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = AirlineReserveCubit();
        cubit.fetchAirlineFlight(airlineId: airline.airlineId,destinationId: destinationId);
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Airline Booking',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white)),
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
          decoration:  BoxDecoration(
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
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: BlocConsumer<AirlineReserveCubit, AirlineReserveState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      MySnackBar(state.errorMessage.toString(), context);
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<AirlineReserveCubit>();

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
                                      color: Theme.of(context).colorScheme.secondary,
                                      letterSpacing: 0.5,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Select your airline preferences',
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

                              _buildDropdownSection(
                                context: context,
                                title: 'Airline Flight',
                                // إذا لم يُختَر أي flight اعرض placeholder، وإلا اعرض رقم الرحلة
                                value: state.selectedAirlineFlight == null
                                    ? 'Select Airline Flight'
                                    : 'Flight number: ${state.selectedAirlineFlight!.flightNumber}',
                                icon: Icons.location_pin,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap: () => _showSelectionModal<Airlineflights>(
                                  context: context,
                                  title: 'Select Airline Flight',
                                  items: state.airLineFlights,
                                  itemBuilder: (e) => e.flightDate,
                                  onSelect: (value) => cubit.selectAirlineFlight(value),
                                  selectionType: 'Airline Flight',
                                ),
                                isEnabled: state.airLineFlights.isNotEmpty,
                              ),


                              const SizedBox(height: 10),

                              _buildDropdownSection(
                                context: context,
                                title: 'Seat Type',
                                value: state.selectedAirlineSeats?.seatClass ?? 'Select Seat Type',
                                icon: Icons.airline_seat_recline_extra,
                                color: Theme.of(context).colorScheme.secondary,
                                isEnabled: state.airLineSeats.isNotEmpty,
                                onTap: state.airLineSeats.isNotEmpty
                                    ? () => _showSelectionModal<AirLineSeats>(
                                  context: context,
                                  title: 'Select Seat Type',
                                  items: state.airLineSeats,
                                  itemBuilder: (e) => e.seatClass,
                                  onSelect: (value) =>
                                      cubit.selectAirlineSeat(value),
                                  selectionType: 'seatType',
                                )
                                    : null,
                              ),

                              const SizedBox(height: 10),

                              _buildDropdownSection(
                                context: context,
                                title: 'Number of Tickets',
                                value: state.selectedCapacity?.toString(),
                                icon: Icons.confirmation_number,
                                color: Theme.of(context).colorScheme.secondary,
                                onTap:(state.selectedAirlineSeats == null ||
                                state.capacities.isEmpty)
                                  ? null
                                    :
                                 () => _showSelectionModal<int>(
                                  context: context,
                                  title: 'Select Ticket Quantity',
                                  items: state.capacities,
                                  itemBuilder: (e) => e.toString(),
                                  onSelect: (value) =>
                                      cubit.selectCapacity(value),
                                  selectionType: 'capacity',
                                ),
                                isEnabled: state.selectedAirlineSeats!=null,
                              ),

                              const SizedBox(height: 10),

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
                                        Theme.of(context).colorScheme.secondary.withOpacity(0.4),
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
                                      await cubit.fetchAirlinePriceDetails(
                                        airlineFlight: state.selectedAirlineFlight!,
                                        airlineSeat: state.selectedAirlineSeats!,
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
                                            child: BlocBuilder<AirlineReserveCubit,
                                                AirlineReserveState>(
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
                                                    title:  Row(
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
                                                        buildPriceRow("Flight Price",
                                                            "${priceData["flight_price"]} \$",context: context),
                                                        buildPriceRow(
                                                            "Total Flight Price",
                                                            "${priceData["total_flight_price"]} \$",context: context),
                                                        buildPriceRow("Flight Seat",
                                                            "${priceData["flight_seat"]} \$",context: context),
                                                        buildPriceRow(
                                                            "Total Seat Price",
                                                            "${priceData["total_flight_seat_price"]} \$",context: context),
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
                                                        child: Text(
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
                                                              .reserveAirline(
                                                            airlineFlight: state
                                                                .selectedAirlineFlight!,
                                                            airlineSeat: state
                                                                .selectedAirlineSeats!,
                                                            capacity: state
                                                                .selectedCapacity!,
                                                            paymentWay: state
                                                                .selectedPaymentMethod!,
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
                                                          backgroundColor:Theme.of(context).primaryColor,
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
                  color: Theme.of(context).colorScheme.secondary,
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
      borderRadius: BorderRadius.all(Radius.circular(16)),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.secondary, // ظل أقوى قليلاً (شفاف أسود)
          blurRadius: 20,
          spreadRadius: 4,
          offset: Offset(0, 8), // ظل للأسفل
        ),
      ],
    );

    // Airline Flight
    if (item is Airlineflights) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: cardDecoration, // keep your existing decoration
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight Number
            Row(
              children: [
                Icon(Icons.flight, color: Theme.of(context).iconTheme.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Flight # ${item.flightNumber}",
                  style: mainTextStyle
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Date
            Row(
              children: [
                Icon(Icons.calendar_today, color: Theme.of(context).iconTheme.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Date Time: ${item.flightDate}',
                  style: mainTextStyle
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Departure Time
            Row(
              children: [
                Icon(Icons.schedule, color: Theme.of(context).iconTheme.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Departure Time: ${item.depatureTime}",
                  style: mainTextStyle
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Arrival Time
            Row(
              children: [
                 Icon(Icons.schedule, color: Theme.of(context).iconTheme.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Arrival Time: ${item.arrivalTime}",
                  style:mainTextStyle
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Price
            Row(
              children: [
                 Icon(Icons.attach_money, color: Theme.of(context).iconTheme.color, size: 24),
                const SizedBox(width: 8),
                Text(
                  "${item.price} \$",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Status
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color, size: 24),
                const SizedBox(width: 8),
                 Text(
                  "Status: ",
                  style: mainTextStyle
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: item.status.toLowerCase() == 'scheduled'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: item.status.toLowerCase() == 'scheduled'
                          ? Colors.green[700]
                          : Colors.red[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }


    // Seat Type
    else if (item is AirLineSeats) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: cardDecoration, // احتفظ بزخرفتك الحالية
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صف يحتوى على الأيقونة واسم الصنف والسعر
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.airline_seat_recline_extra,
                  color: Theme.of(context).iconTheme.color,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  // Expanded هنا قانوني لأن والده Row
                  child: Text(
                    item.seatClass.toUpperCase(),
                    style: mainTextStyle
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${item.price} \$",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // نص عدد المقاعد المتاحة
            Text(
              "${item.seatCount} seats available",
              style: mainTextStyle
            ),
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
             Icon(Icons.confirmation_number, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 8),
            Text("$item Ticket${item > 1 ? 's' : ''}", style: mainTextStyle),
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
