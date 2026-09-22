import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsState.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:gaagls/model/resturant.dart';
import 'package:gaagls/view/widgets/mySnackBar.dart';
import 'package:gaagls/view/widgets/peopleTextField.dart';
import '../widgets/dateTextField.dart';
import '../widgets/locationDropdown.dart';
import '../widgets/timeTextField.dart';

class ResturantDetailsPage extends StatefulWidget {
  final Resturant resturant;

  ResturantDetailsPage({Key? key, required this.resturant}) : super(key: key);

  @override
  State<ResturantDetailsPage> createState() => _ResturantDetailsPageState();
}

class _ResturantDetailsPageState extends State<ResturantDetailsPage> {
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _starttimeController = TextEditingController();

  final TextEditingController _endtimeController = TextEditingController();

  final TextEditingController _peopleController = TextEditingController();

  final ValueNotifier<String?> _locationValueNotifier =
      ValueNotifier<String?>('inside');


  // Future<void> _selectedDate(
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
  //     controller.text = pickedDate.toString().split(" ")[0];
  //   }
  // }

  Future<void> _selectedDate(
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
      controller.text = pickedDate.toString().split(" ")[0];
    }
  }


  // Future<void> _startselectTime(
  //     TextEditingController controller, BuildContext context) async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.blue,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //           dialogBackgroundColor: Colors.white,
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (pickedTime != null) {
  //     controller.text = pickedTime.format(context);
  //   }
  // }
  //
  // Future<void> _endselectTime(
  //     TextEditingController controller, BuildContext context) async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: Colors.blue,
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //           dialogBackgroundColor: Colors.white,
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (pickedTime != null) {
  //     controller.text = pickedTime.format(context);
  //   }
  // }


  Future<void> _startselectTime(
      TextEditingController controller, BuildContext context) async {
    final theme = Theme.of(context);

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,     // لون الأزرار والعنوان
              onPrimary: theme.colorScheme.onPrimary, // لون النص فوق اللون الأساسي
              onSurface: theme.colorScheme.onSurface, // لون النصوص العادية
            ),
            dialogBackgroundColor: theme.colorScheme.surface, // خلفية مربع الحوار
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
    }
  }

  Future<void> _endselectTime(
      TextEditingController controller, BuildContext context) async {
    final theme = Theme.of(context);

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              onSurface: theme.colorScheme.onSurface,
            ),
            dialogBackgroundColor: theme.colorScheme.surface,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      controller.text = pickedTime.format(context);
    }
  }


  void _clearFields() {
    _dateController.clear();
    _starttimeController.clear();
    _endtimeController.clear();
    _peopleController.clear();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _starttimeController.dispose();
    _endtimeController.dispose();
    _peopleController.dispose();
    _locationValueNotifier.dispose();
    super.dispose();
  }

  Widget _buildCard(
      {required Widget child,
      Color backgroundColor = const Color(0xFFF9FBFF)}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // استخدام اللون المخصص
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // زيادة الظل هنا
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.5), // زيادة الشفافية
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


  // تعديل دالة معلومات الوجهة لقبول لون خلفية مخصص
  Widget _buildDestinationInfo({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color backgroundColor
    }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.1), width: 1.5),
        boxShadow: [
          // إضافة ظل خفيف
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;
    final isSmallScreen = screenWidth < 600;

    return BlocListener<RestaurantsCubit, RestaurantsState>(
      listener: (context, state) {
        if (state is RestaurantsBookingSuccess) {
          Navigator.pop(context);
          MySnackBar(state.message, context);
          _clearFields();
        } else if (state is RestaurantsBookingFailure) {
          MySnackBar(state.message, context);
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight * 0.35,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.resturant.resturantName,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 15, // زيادة الظل هنا
                        offset: Offset(1, 2), // زيادة الإزاحة
                      )
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: widget.resturant.resturantId,
                      child: CachedNetworkImage(
                        imageUrl: widget.resturant.resturantImage ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                            ),
                          ),
                          child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                            ),
                          ),
                          child: const Icon(Icons.image,
                              color: Colors.white70, size: 50),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,20,20,90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    _buildCard(
                      backgroundColor: Theme.of(context).cardColor,
                      child: Column(
                        children: [
                          // Timeline row - تم تغيير لون الخلفية هنا
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor, // لون أفتح
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                // إضافة ظل خفيف
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.lock_open,
                                            color: Theme.of(context).colorScheme.secondary, size: 24),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.resturant.openTime,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Opening Time",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ],
                                ),

                                // فاصل بسيط بين الأوقات
                                Container(
                                  height: 40,
                                  width: 2,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),

                                // وقت الإغلاق
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                         Icon(Icons.lock_clock,
                                            color: Theme.of(context).colorScheme.secondary, size: 24),
                                        const SizedBox(width: 6),
                                        Text(
                                          widget.resturant.closeTime,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.secondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Closing Time",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),


                    SizedBox(
                      width: screenWidth,
                      child: _buildCard(
                        backgroundColor: Theme.of(context).cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Restaurant Description",
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              widget.resturant.description,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                height: 1.6,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),


                    _buildCard(
                      backgroundColor:Theme.of(context).cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Restaurant Location",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDestinationInfo(
                                  icon : Icons.location_city,
                                  title: "City",
                                  value: '${widget.resturant.city}, ${widget.resturant.location}',
                                  color: Theme.of(context).colorScheme.secondary,
                                  backgroundColor:
                                  Theme.of(context).cardColor, // لون خلفية جديد
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _buildDestinationInfo(
                                  icon: Icons.flag,
                                  title: "Country",
                                  value: widget.resturant.country,
                                  color : Colors.green.shade700,
                                  backgroundColor:
                                  Theme.of(context).cardColor, // لون خلفية جديد
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildCard(
                      backgroundColor: Theme.of(context).cardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Restaurant Rating",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ✅ التقييم داخل child مباشرة
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                  color: Colors.blue.shade100, width: 1.2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Restaurant Rating",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RatingBarIndicator(
                                  rating: double.tryParse(
                                          widget.resturant.stars.toString()) ??
                                      0,
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          height: isSmallScreen ? 55 : 65,
          width: screenWidth * (isSmallScreen ? 0.95 : 0.9),
          margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              // زيادة الظل هنا
              BoxShadow(
                color: Colors.blue.shade700.withOpacity(0.5),
                blurRadius: 20, // زيادة من 15 إلى 20
                spreadRadius: 3, // زيادة من 2 إلى 3
                offset: const Offset(0, 6), // زيادة من 5 إلى 6
              ),
            ],
            gradient: const LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)],
              // تعديل طفيف في التدرج
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),


              onTap: (){
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return BlocBuilder<RestaurantsCubit, RestaurantsState>(
                      builder: (context, state) {
                        final isLoading = state is RestaurantsLoading;

                        return WillPopScope(
                          onWillPop: () async => false, // يمنع الرجوع بزر الجهاز
                          child: AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Theme.of(context).cardColor,
                            title: Text(
                              'Enter Reservation Information',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: SizedBox(
                              height: screenHeight * 0.55,
                              width: screenWidth * 0.8,
                              child: IgnorePointer(
                                ignoring: isLoading,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('Reservation Date'),
                                      DateTextField(
                                        controller: _dateController,
                                        onTap: () => _selectedDate(context, _dateController),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildLabel('Start Time'),
                                      TimeTextField(
                                        controller: _starttimeController,
                                        onTap: () => _startselectTime(_starttimeController, context),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildLabel('End Time'),
                                      TimeTextField(
                                        controller: _endtimeController,
                                        onTap: () => _endselectTime(_endtimeController, context),
                                      ),
                                      const SizedBox(height: 12),
                                      _buildLabel('People Count'),
                                      PeopleTextField(controller: _peopleController),
                                      const SizedBox(height: 12),
                                      _buildLabel('Location'),

                                      ValueListenableBuilder<String?>(
                                        valueListenable: _locationValueNotifier,
                                        builder: (context, selectedValue, _) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).secondaryHeaderColor,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  blurRadius: 6,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: selectedValue,
                                                hint: Text(
                                                  'اختر الموقع',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.secondary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                isExpanded: true,
                                                icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color),
                                                dropdownColor: Theme.of(context).secondaryHeaderColor,
                                                borderRadius: BorderRadius.circular(16),
                                                style: TextStyle(
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                items: [
                                                  DropdownMenuItem(
                                                    value: 'inside',
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: Text('Inside',style: TextStyle(color: Theme.of(context).iconTheme.color),),
                                                    ),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'outside',
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: Text('Outside',style: TextStyle(color: Theme.of(context).iconTheme.color),),
                                                    ),
                                                  ),
                                                ],
                                                onChanged: (val) {
                                                  _locationValueNotifier.value = val;
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
                                  'Cancel',
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
                                  final date = _dateController.text.trim();
                                  final count = _peopleController.text.trim();
                                  final location = _locationValueNotifier.value;

                                  String? start;
                                  String? end;

                                  if (_starttimeController.text.trim().isNotEmpty) {
                                    try {
                                      start = Globals.convertTime12to24(_starttimeController.text.trim());
                                    } catch (_) {
                                      start = null;
                                    }
                                  }
                                  if (_endtimeController.text.trim().isNotEmpty) {
                                    try {
                                      end = Globals.convertTime12to24(_endtimeController.text.trim());
                                    } catch (_) {
                                      end = null;
                                    }
                                  }

                                  if (date.isEmpty || count.isEmpty || location == null || location.isEmpty || start == null || end == null) {
                                    MySnackBar('All fields are required', context, isError: true);
                                  } else {
                                    int countPeople = int.parse(count);
                                    context.read<RestaurantsCubit>().bookingRestaurant(
                                      date: date,
                                      startTime: start,
                                      endTime: end,
                                      numOfSeats: countPeople,
                                      location: location,
                                      restaurantId: widget.resturant.resturantId,
                                    );
                                  }
                                },
                                child: isLoading
                                    ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                                    : Text(
                                  'Confirm',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
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



              // onTap: () {
              //   showDialog(
              //     context: context,
              //     barrierDismissible: false,
              //     // منع الإغلاق بالضغط خارج الـ Dialog
              //     builder: (context) {
              //       return BlocBuilder<RestaurantsCubit, RestaurantsState>(
              //         builder: (context, state) {
              //           final isLoading = state is RestaurantsLoading;
              //
              //           return WillPopScope(
              //             onWillPop: () async => !isLoading,
              //             child: AlertDialog(
              //               title: const Text(
              //                 'Enter reservation information',
              //                 style: TextStyle(
              //                     fontSize: 17, fontWeight: FontWeight.bold),
              //               ),
              //               content: SizedBox(
              //                 height: screenHeight * 0.5,
              //                 width: screenWidth * 0.7,
              //                 child: SingleChildScrollView(
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       DateTextField(
              //                         controller: _dateController,
              //                         onTap: () => _selectedDate(
              //                             context, _dateController),
              //                       ),
              //                       const SizedBox(height: 5),
              //                       const Text('Start Time',
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 17)),
              //                       const SizedBox(height: 5),
              //                       TimeTextField(
              //                         controller: _starttimeController,
              //                         onTap: () => _startselectTime(
              //                             _starttimeController, context),
              //                       ),
              //                       const SizedBox(height: 5),
              //                       const Text('End Time',
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 17)),
              //                       const SizedBox(height: 5),
              //                       TimeTextField(
              //                         controller: _endtimeController,
              //                         onTap: () => _endselectTime(
              //                             _endtimeController, context),
              //                       ),
              //                       const SizedBox(height: 5),
              //                       const Text('People Count',
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 17)),
              //                       const SizedBox(height: 5),
              //                       PeopleTextField(
              //                           controller: _peopleController),
              //                       const SizedBox(height: 5),
              //                       const Text('Location',
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 17)),
              //                       const SizedBox(height: 5),
              //                       ValueListenableBuilder<String?>(
              //                         valueListenable: _locationValueNotifier,
              //                         builder: (context, selectedValue, _) {
              //                           return LocationDropdown(
              //                             value: selectedValue,
              //                             items: const ['inside', 'outside'],
              //                             onChanged: (newValue) {
              //                               _locationValueNotifier.value =
              //                                   newValue;
              //                             },
              //                           );
              //                         },
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               actions: isLoading
              //                   ? [
              //                       const Padding(
              //                         padding:
              //                             EdgeInsets.symmetric(vertical: 12),
              //                         child: Center(
              //                           child: SizedBox(
              //                             width: 30,
              //                             height: 30,
              //                             child: CircularProgressIndicator(
              //                                 strokeWidth: 3),
              //                           ),
              //                         ),
              //                       )
              //                     ]
              //                   : [
              //                       TextButton(
              //                         onPressed: () {
              //                           Navigator.pop(context);
              //                           _clearFields();
              //                         },
              //                         child: const Text('إلغاء'),
              //                       ),
              //                       ElevatedButton(
              //                         onPressed: () {
              //                           final date =
              //                               _dateController.text.trim();
              //                           final count =
              //                               _peopleController.text.trim();
              //                           final location =
              //                               _locationValueNotifier.value;
              //
              //                           String? start;
              //                           String? end;
              //
              //                           if (_starttimeController.text
              //                               .trim()
              //                               .isNotEmpty) {
              //                             try {
              //                               start = Globals.convertTime12to24(
              //                                   _starttimeController.text
              //                                       .trim());
              //                             } catch (_) {
              //                               start = null;
              //                             }
              //                           }
              //                           if (_endtimeController.text
              //                               .trim()
              //                               .isNotEmpty) {
              //                             try {
              //                               end = Globals.convertTime12to24(
              //                                   _endtimeController.text.trim());
              //                             } catch (_) {
              //                               end = null;
              //                             }
              //                           }
              //
              //                           if (date.isEmpty ||
              //                               count.isEmpty ||
              //                               location == null ||
              //                               location.isEmpty ||
              //                               start == null ||
              //                               end == null) {
              //                             MySnackBar('All Fields Are required',
              //                                 context,
              //                                 isError: true);
              //                           } else {
              //                             int countPeople = int.parse(count);
              //                             context
              //                                 .read<RestaurantsCubit>()
              //                                 .bookingRestaurant(
              //                                   date: date,
              //                                   startTime: start,
              //                                   endTime: end,
              //                                   numOfSeats: countPeople,
              //                                   location: location,
              //                                   restaurantId: widget
              //                                       .resturant.resturantId,
              //                                 );
              //                           }
              //                         },
              //                         child: const Text('تأكيد'),
              //                       ),
              //                     ],
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   );
              // },


              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.confirmation_number,
                      color: Colors.white, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    'Book Now',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 18 : 20,
                      shadows: const [
                        // إضافة ظل للنص
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   final screenHeight = MediaQuery.of(context).size.height;
//   final screenWidth = MediaQuery.of(context).size.width;
//   return BlocListener<RestaurantsCubit, RestaurantsState>(
//     listener: (context, state) {
//       if (state is RestaurantsBookingSuccess) {
//         Navigator.pop(context);
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //    SnackBar(content: Text(state.message)),
//         // );
//         MySnackBar(state.message, context);
//         _clearFields();
//       } else if (state is RestaurantsBookingFailure) {
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(content: Text(state.message)),
//         // );
//         MySnackBar(state.message, context);
//       }
//     },
//     child: Scaffold(
//       appBar: AppBar(
//         title: Text(widget.resturant.resturantName),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // صورة المطعم
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
//               child: CachedNetworkImage(
//                  imageUrl:
//                   widget.resturant.resturantImage ?? '',
//                   width: double.infinity,
//                   height: 220,
//                   fit: BoxFit.cover,
//                 placeholder: (context, url) => Container(
//                   width: 120,
//                   height: 90,
//                   color: Colors.grey[300],
//                 ),
//                 errorWidget: (context, url, error) => const Icon(Icons.error, size: 30),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // الاسم
//                   Text(
//                     widget.resturant.resturantName,
//                     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // التقييم
//                   Row(
//                     children: [
//                       const Icon(Icons.star, color: Colors.orange),
//                       const SizedBox(width: 6),
//                       Text("${widget.resturant.stars} نجوم", style: const TextStyle(fontSize: 16)),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // الموقع
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on, color: Colors.red),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           "${widget.resturant.city}, ${widget.resturant.country}",
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // الموقع التفصيلي
//                   Row(
//                     children: [
//                       const Icon(Icons.map, color: Colors.blueGrey),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Text(
//                           widget.resturant.location,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   // ساعات العمل
//                   Row(
//                     children: [
//                       const Icon(Icons.access_time, color: Colors.green),
//                       const SizedBox(width: 6),
//                       Text(
//                         "من ${widget.resturant.openTime} إلى ${widget.resturant.closeTime}",
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//
//                   const Divider(height: 32),
//
//                   // وصف
//                   const Text(
//                     "الوصف",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     widget.resturant.description,
//                     style: const TextStyle(fontSize: 16, height: 1.5),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//
//
//             GestureDetector(
//               onTap: () {
//                 showDialog(
//                   context: context,
//                   barrierDismissible: false, // منع الإغلاق بالضغط خارج الـ Dialog
//                   builder: (context) {
//
//                       return BlocBuilder<RestaurantsCubit, RestaurantsState>(
//                         builder: (context, state) {
//                           final isLoading = state is RestaurantsLoading;
//
//                           return WillPopScope(
//                             onWillPop: () async => !isLoading,
//                             child: AlertDialog(
//                               title: const Text(
//                                 'Enter reservation informations',
//                                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                               ),
//                               content: SizedBox(
//                                 height: screenHeight * 0.5,
//                                 width: screenWidth * 0.7,
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       DateTextField(
//                                         controller: _dateController,
//                                         onTap: () => _selectedDate(context, _dateController),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       const Text('Start Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                       const SizedBox(height: 5),
//                                       TimeTextField(
//                                         controller: _starttimeController,
//                                         onTap: () => _startselectTime(_starttimeController, context),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       const Text('End Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                       const SizedBox(height: 5),
//                                       TimeTextField(
//                                         controller: _endtimeController,
//                                         onTap: () => _endselectTime(_endtimeController, context),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       const Text('People Count', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                       const SizedBox(height: 5),
//                                       PeopleTextField(controller: _peopleController),
//                                       const SizedBox(height: 5),
//                                       const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
//                                       const SizedBox(height: 5),
//                                       ValueListenableBuilder<String?>(
//                                         valueListenable: _locationValueNotifier,
//                                         builder: (context, selectedValue, _) {
//                                           return LocationDropdown(
//                                             value: selectedValue,
//                                             items: const ['inside', 'outside'],
//                                             onChanged: (newValue) {
//                                               _locationValueNotifier.value = newValue;
//                                             },
//                                           );
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               actions: isLoading
//                                   ? [
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 12),
//                                   child: Center(
//                                     child: SizedBox(
//                                       width: 30,
//                                       height: 30,
//                                       child: CircularProgressIndicator(strokeWidth: 3),
//                                     ),
//                                   ),
//                                 )
//                               ]
//                                   : [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                     _clearFields();
//                                   },
//                                   child: const Text('إلغاء'),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     final date = _dateController.text.trim();
//                                     final count = _peopleController.text.trim();
//                                     final location = _locationValueNotifier.value;
//
//                                     String? start;
//                                     String? end;
//
//                                     if (_starttimeController.text.trim().isNotEmpty) {
//                                       try {
//                                         start = Globals.convertTime12to24(_starttimeController.text.trim());
//                                       } catch (_) {
//                                         start = null;
//                                       }
//                                     }
//
//                                     if (_endtimeController.text.trim().isNotEmpty) {
//                                       try {
//                                         end = Globals.convertTime12to24(_endtimeController.text.trim());
//                                       } catch (_) {
//                                         end = null;
//                                       }
//                                     }
//
//                                     if (date.isEmpty || count.isEmpty || location == null || location.isEmpty || start == null || end == null) {
//                                       MySnackBar('All Fields Are required', context);
//                                     } else {
//                                       int countPeople = int.parse(count);
//                                       context.read<RestaurantsCubit>().bookingRestaurant(
//                                         date: date,
//                                         startTime: start,
//                                         endTime: end,
//                                         numOfSeats: countPeople,
//                                         location: location,
//                                         restaurantId: widget.resturant.resturantId,
//                                       );
//                                     }
//                                   },
//                                   child: const Text('تأكيد'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                     );
//                   },
//                 );
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: screenHeight * 0.15,
//                   horizontal: 50,
//                 ),
//                 child: Center(
//                   child: Container(
//                     height: screenHeight * 0.1,
//                     width: screenWidth * 0.8,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blue, width: 4),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'Reserve Now',
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
