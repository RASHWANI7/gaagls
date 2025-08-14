import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaagls/controller/cubits/RoomBookingCubit/RoomBookingCubit.dart';
import 'package:gaagls/controller/cubits/RoomBookingCubit/RoomBookingState.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import '../../model/room.dart';
import '../widgets/dateTextField.dart';
import '../widgets/locationDropdown.dart';

class RoomDetailsPage extends StatefulWidget {
  final Room room;

  RoomDetailsPage({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  final TextEditingController _checkInController = TextEditingController();

  final TextEditingController _checkOutController = TextEditingController();

  final ValueNotifier<String?> _paymentValueNotifier =
      ValueNotifier<String?>('Credit Card');

  // // دالة اختيار التاريخ
  // Future<void> _selectedCheckInDate(
  //     BuildContext context, TextEditingController controller) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2029),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           dialogBackgroundColor: Theme.of(context).colorScheme.primary,
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.blue,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Colors.blue,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (pickedDate != null) {
  //     // ✅ التاريخ الذي اختاره المستخدم
  //     final selectedDate = pickedDate.toString().split(" ")[0];
  //
  //     // ✅ التاريخ الثابت الذي تريد إضافته
  //     const fixedDate = "12:00:00";
  //
  //     // ✅ دمج القيمتين في الحقل
  //     controller.text = "$selectedDate $fixedDate";
  //   }
  // }


  // دالة اختيار التاريخ
  Future<void> _selectedCheckInDate(
      BuildContext context, TextEditingController controller) async {
    final theme = Theme.of(context);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2029),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            dialogBackgroundColor: theme.colorScheme.surface, // خلفية مربع الحوار
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,     // لون الأزرار وشريط العنوان
              onPrimary: theme.colorScheme.onPrimary, // لون النص فوق الـ primary
              surface: theme.colorScheme.surface,     // لون الخلفية الداخلية
              onSurface: theme.colorScheme.onSurface, // لون النصوص داخل التقويم
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary, // لون أزرار CANCEL و OK
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // ✅ التاريخ الذي اختاره المستخدم
      final selectedDate = pickedDate.toString().split(" ")[0];

      // ✅ التاريخ الثابت الذي تريد إضافته
      const fixedDate = "12:00:00";

      // ✅ دمج القيمتين في الحقل
      controller.text = "$selectedDate $fixedDate";
    }
  }




  // Future<void> _selectedCheckOutDate(
  //     BuildContext context, TextEditingController controller) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2029),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           dialogBackgroundColor: Theme.of(context).colorScheme.primary,
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.blue,
  //           ),
  //           textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               foregroundColor: Colors.blue,
  //             ),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (pickedDate != null) {
  //     // ✅ التاريخ الذي اختاره المستخدم
  //     final selectedDate = pickedDate.toString().split(" ")[0];
  //
  //     // ✅ التاريخ الثابت الذي تريد إضافته
  //     const fixedDate = "12:00:00";
  //
  //     // ✅ دمج القيمتين في الحقل
  //     controller.text = "$selectedDate $fixedDate";
  //   }
  // }

  Future<void> _selectedCheckOutDate(
      BuildContext context, TextEditingController controller) async {
    final theme = Theme.of(context);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2029),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            dialogBackgroundColor: theme.colorScheme.surface, // خلفية صندوق الحوار
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,     // لون الأزرار وشريط العنوان
              onPrimary: theme.colorScheme.onPrimary, // لون النص فوق الـ primary
              surface: theme.colorScheme.surface,     // لون الخلفية الداخلية
              onSurface: theme.colorScheme.onSurface, // لون النصوص داخل التقويم
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.primary, // لون أزرار CANCEL و OK
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // ✅ التاريخ الذي اختاره المستخدم
      final selectedDate = pickedDate.toString().split(" ")[0];

      // ✅ التاريخ الثابت الذي تريد إضافته
      const fixedDate = "12:00:00";

      // ✅ دمج القيمتين في الحقل
      controller.text = "$selectedDate $fixedDate";
    }
  }


  void _clearFields() {
    _checkInController.clear();
    _checkOutController.clear();
  }

  @override
  void dispose() {
    _checkInController.dispose();
    _checkOutController.dispose();
    _paymentValueNotifier.dispose();
    super.dispose();
  }


  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = MediaQuery.of(context).size.width < 400;
    final theme = Theme.of(context);



    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: ElevatedButton.icon(

          onPressed: (){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return BlocConsumer<RoomBookingCubit, RoomBookingState>(
                  listener: (context, state) {
                    if (state is RoomBookingSuccess) {
                      Navigator.pop(context);
                      MySnackBar( state.message,context);
                      _clearFields();
                    } else if (state is RoomBookingFailure) {
                      MySnackBar(state.message, context,isError: false);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is RoomBookingLoading;

                    return WillPopScope(
                      onWillPop: () async => false, // يمنع الرجوع بزر الجهاز
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Theme.of(context).dialogBackgroundColor,
                        title: Text(
                          'Enter Room Information',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: screenHeight*0.38,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Check In Date'),
                                DateTextField(
                                  controller: _checkInController,
                                  onTap: () => _selectedCheckInDate(context, _checkInController),

                                ),
                                const SizedBox(height: 16),
                                _buildLabel('Check Out Date'),
                                DateTextField(
                                  controller: _checkOutController,
                                  onTap: () => _selectedCheckOutDate(context, _checkOutController),

                                ),
                                const SizedBox(height: 16),
                                _buildLabel('Payment Way'),

                                ValueListenableBuilder<String?>(
                                  valueListenable: _paymentValueNotifier,
                                  builder: (context, selectedValue, _) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).secondaryHeaderColor, // خلفية زرقاء فاتحة
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).primaryColor,
                                            blurRadius: 1,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: selectedValue,
                                          isExpanded: true,
                                          dropdownColor: Theme.of(context).secondaryHeaderColor,
                                          borderRadius: BorderRadius.circular(16),
                                          icon: Icon(Icons.expand_more, color: Theme.of(context).iconTheme.color, size: 26),
                                          style: TextStyle(
                                            color: Theme.of(context).iconTheme.color,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          hint: const Text(
                                            'Choose a payment method',
                                            style: TextStyle(
                                              color: Color(0xFF0D47A1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              value: 'Credit Card',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.credit_card, color: Theme.of(context).iconTheme.color),
                                                  const SizedBox(width: 10),
                                                  const Text('Credit Card'),
                                                ],
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: 'paypal',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.account_balance_wallet, color: Theme.of(context).iconTheme.color),
                                                  const SizedBox(width: 10),
                                                  const Text('Paypal'),
                                                ],
                                              ),
                                            ),
                                          ],
                                          onChanged: (val) {
                                            _paymentValueNotifier.value = val;
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),


                              ],
                            ),
                          ),
                        ),
                        actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        actions: [
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                              Navigator.pop(context);
                              _clearFields();
                            },
                            child: Text(
                              'cancel',
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            onPressed: isLoading
                                ? null
                                : () {
                              final checkIn = _checkInController.text.trim();
                              final checkOut = _checkOutController.text.trim();
                              final paymentWay = _paymentValueNotifier.value;

                              if (checkIn.isEmpty || checkOut.isEmpty || paymentWay == null || paymentWay.isEmpty) {
                                MySnackBar( 'All Fields Are required', context,isError: true);
                              } else {
                                context.read<RoomBookingCubit>().bookingRoom(
                                  checkIn: checkIn,
                                  checkOut: checkOut,
                                  paymentWay: paymentWay,
                                  roomId: widget.room.roomId,
                                );
                              }
                            },
                            child: isLoading
                                ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                            )
                                : Text(
                              'confirm',
                              style: TextStyle(fontSize: 16,color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          icon: Icon(Icons.hotel_rounded, size: 26,color: Colors.white,),
          label:  Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              "Book This Room",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).iconTheme.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 270,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'room_${widget.room.roomId}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.room.roomImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // المحتوى
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // نوع الغرفة + الأيقونة
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.king_bed,
                        title: "Room Type",
                        value: widget.room.type,
                        color: Colors.indigo,
                        isSmallScreen: isSmallScreen,
                        backgroundColor: Theme.of(context).cardColor,
                        context: context
                      ),
                      const SizedBox(width: 15,),
                      _buildInfoCard(
                        icon: Icons.people,
                        title: "Capacity",
                        value: '${widget.room.capacity}',
                        color: Colors.teal,
                        isSmallScreen: isSmallScreen,
                        backgroundColor: Theme.of(context).cardColor,
                        context: context
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // معلومات رئيسية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCard(
                        backgroundColor:  Theme.of(context).cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ✅ التقييم داخل child مباشرة
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hotel Rating",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RatingBarIndicator(
                                  rating: double.tryParse(widget.room.rating.toString()) ?? 0,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star_rounded,
                                    color: Colors.yellow[600],
                                  ),
                                  itemCount: 5,
                                  itemSize: 28.0,
                                  unratedColor: Colors.blue.shade100,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                          ],
                        ),
                        context: context
                      ),
                      const SizedBox(width: 15,),
                      _buildInfoCard(
                        icon: Icons.monetization_on_rounded,
                        title: "Price per day",
                        value: '${widget.room.price} \$',
                        color: Colors.green,
                        isSmallScreen: isSmallScreen,
                        backgroundColor: Theme.of(context).cardColor,
                        context: context
                      ),
                    ],
                  ),


                  const SizedBox(height: 25),

                  // الحالة
                  _buildHotelFeature(
                    Icons.verified,
                    "Status",
                    widget.room.roomStatus,
                    widget.room.roomStatus.toLowerCase() == 'available'
                        ? Colors.green
                        : Colors.red,
                    context
                  ),

                  const SizedBox(height: 30),

                  // وصف الغرفة
                  Text(
                    "Description",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.room.description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),

                  const SizedBox(height: 100), // مساحة للزر بالأسفل
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// تعديل دالة بطاقة المعلومات لقبول لون خلفية مخصص
Widget _buildInfoCard({
  required IconData icon,
  required String title,
  required String value,
  required Color color,
  required bool isSmallScreen,
  required Color backgroundColor, // لون خلفية جديد
  required BuildContext context
}) {
  return Container(
    width: isSmallScreen ? 140 : 170,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: backgroundColor, // استخدام اللون المخصص
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.2), width: 1.5),
      boxShadow: [
        // إضافة ظل خفيف
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          blurRadius: 6,
          spreadRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: isSmallScreen ? 15 : 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildHotelFeature(
    IconData icon, String title, String value, Color color,BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor.withOpacity(0.6),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.4),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(color: Theme.of(context).primaryColor, width: 1),
    ),
    child: Row(
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


// تعديل دالة البطاقة لقبول لون خلفية مخصص
Widget _buildCard({required Widget child, required Color backgroundColor,required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor, // استخدام اللون المخصص
      borderRadius: BorderRadius.circular(20),
      boxShadow: [ // زيادة الظل هنا
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.5), // زيادة الشفافية
          blurRadius: 20, // زيادة من 15 إلى 20
          spreadRadius: 3, // زيادة من 2 إلى 3
          offset: const Offset(0, 6), // زيادة من 5 إلى 6
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: child,
    ),
  );
}