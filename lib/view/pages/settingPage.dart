import 'dart:async';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/pages/signIn_Page.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/cubits/settingCubit/settingCubit.dart';
import '../../controller/cubits/settingCubit/settingState.dart';
import '../../controller/cubits/theme_cubit/theme_cubit.dart';
import '../../model/cities.dart';
import '../widgets/customCountryPicker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController countryController = TextEditingController();

  final List<String> languages = const ['English', 'Arabic'];

  @override
  void initState() {
    super.initState();
    context.read<SettingsCubit>().getCountries();
  }

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }

  Cities? selectedCity;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight*0.05,horizontal: 15),
          // child: Column(
          //   children: [
          //     Text('Settings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          //     SizedBox(height: screenHeight*0.02),
          //
          // //       SwitchListTile(
          // // title: const Text("الوضع الليلي"),
          // // value: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark,
          // // onChanged: (val) {
          // //   context.read<ThemeCubit>().toggleTheme(val);
          // // },
          // //       ),
          //
          //     Card(
          //       color: Theme.of(context).cardColor,
          //       elevation: 4,
          //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Row(
          //               children: [
          //                 Icon(
          //                   context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
          //                       ? Icons.mode_night
          //                       : Icons.wb_sunny,
          //                   color: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
          //                       ? Colors.yellow[600]
          //                       : Colors.yellow[800],
          //                   size: 28,
          //                 ),
          //                 const SizedBox(width: 12),
          //                 Text(
          //                   "Dark Mode",
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.bold,
          //                     color: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
          //                         ? Colors.white
          //                         : Colors.black87,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             // Switch مخصص مع تأثير مميز
          //             Transform.scale(
          //               scale: 1.2,
          //               child: Switch(
          //                 activeColor: Colors.yellow[600],
          //                 activeTrackColor: Theme.of(context).scaffoldBackgroundColor,
          //                 inactiveThumbColor: Colors.white,
          //                 inactiveTrackColor: Colors.grey[300],
          //                 value: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark,
          //                 onChanged: (val) {
          //                   context.read<ThemeCubit>().toggleTheme(val);
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //       // Padding(
          //       //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //       //   child: Builder(
          //       //     builder: (context) {
          //       //       final isDark = context.select<ThemeCubit, bool>(
          //       //             (cubit) => cubit.state.themeMode == ThemeMode.dark,
          //       //       );
          //       //
          //       //       return Container(
          //       //         height: 65, // نفس حجم الكارد تقريبًا
          //       //         decoration: BoxDecoration(
          //       //           gradient: LinearGradient(
          //       //             colors: isDark
          //       //                 ? [Colors.blueGrey.shade900, Colors.black87]
          //       //                 : [Colors.blue.shade100, Colors.white],
          //       //             begin: Alignment.topLeft,
          //       //             end: Alignment.bottomRight,
          //       //           ),
          //       //           borderRadius: BorderRadius.circular(15),
          //       //           boxShadow: [
          //       //             BoxShadow(
          //       //               color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.3),
          //       //               blurRadius: 12,
          //       //               offset: const Offset(0, 6),
          //       //             ),
          //       //           ],
          //       //         ),
          //       //         child: SwitchListTile.adaptive(
          //       //           title: Text(
          //       //             "الوضع الليلي",
          //       //             style: Theme.of(context).textTheme.titleMedium?.copyWith(
          //       //               fontWeight: FontWeight.bold,
          //       //               color: isDark ? Colors.white : Colors.black87,
          //       //             ),
          //       //           ),
          //       //           secondary: AnimatedSwitcher(
          //       //             duration: const Duration(milliseconds: 400),
          //       //             transitionBuilder: (child, anim) =>
          //       //                 RotationTransition(turns: anim, child: child),
          //       //             child: Icon(
          //       //               isDark ? Icons.nightlight_round : Icons.wb_sunny,
          //       //               key: ValueKey(isDark),
          //       //               color:
          //       //               isDark ? Colors.yellow.shade600 : Colors.orange.shade700,
          //       //               size: 26,
          //       //             ),
          //       //           ),
          //       //           value: isDark,
          //       //           onChanged: (val) {
          //       //             context.read<ThemeCubit>().toggleTheme(val);
          //       //           },
          //       //         ),
          //       //       );
          //       //     },
          //       //   ),
          //       // ),
          //
          //       SizedBox(height: screenHeight*0.05),
          //
          //       BlocBuilder<SettingsCubit, Settingstate>(
          // builder: (context, state) {
          //   final List<Cities> cities = context.read<SettingsCubit>().citiesList;
          //
          //   return CustomCountryPicker(
          //     controller: countryController,
          //     onTap: () =>
          //         _showCountryPicker(context, cities), // ✅ مرر البيانات هنا
          //   );
          // },
          //       ),
          //
          //       // BlocBuilder<SettingsCubit, Settingstate>(
          //       //   builder: (context, state) {
          //       //     if (state is SettingLoading && context.read<SettingsCubit>().citiesList.isEmpty) {
          //       //       // عرض Shimmer أثناء تحميل المدن لأول مرة
          //       //       return buildCitiesShimmer();
          //       //     }
          //       //
          //       //     final List<Cities> cities = context.read<SettingsCubit>().citiesList;
          //       //     return CustomCountryPicker(
          //       //       controller: countryController,
          //       //       onTap: () => _showCountryPicker(context, cities),
          //       //     );
          //       //   },
          //       // ),
          //
          //     SizedBox(height: screenHeight*0.05),
          //
          //         Card(
          //     color: Theme.of(context).cardColor,
          //     elevation: 2,
          //     shape:
          //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //     child: InkWell(
          //         borderRadius: BorderRadius.circular(15),
          //         onTap: () {
          //           _showLogoutDialog(context);
          //         },
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          //           child: Row(
          //             children: [
          //               Icon(Icons.logout, color: Colors.red),
          //               SizedBox(width: 10),
          //               Text(
          //                 'Log out',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   color: Colors.red,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         )))
          //   ],
          // ),


          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // ---------------------- Container الخارجي ----------------------
                          Container(
                            width: screenHeight * 0.9,
                            height: screenHeight*0.6,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // ---------------------- Dark Mode ----------------------

                            Card(
                                  color: Theme.of(context).cardColor,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
                                                  ? Icons.mode_night
                                                  : Icons.wb_sunny,
                                              color: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
                                                  ? Colors.yellow[600]
                                                  : Colors.yellow[800],
                                              size: 28,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              "Dark Mode",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Switch مخصص مع تأثير مميز
                                        Transform.scale(
                                          scale: 1.2,
                                          child: Switch(
                                            activeColor: Theme.of(context).primaryColor,
                                            activeTrackColor: Theme.of(context).scaffoldBackgroundColor,
                                            inactiveThumbColor: Theme.of(context).primaryColor,
                                            inactiveTrackColor: Theme.of(context).secondaryHeaderColor,
                                            value: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark,
                                            onChanged: (val) {
                                              context.read<ThemeCubit>().toggleTheme(val);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.03),

                                // ---------------------- Country Picker ----------------------
                                BlocBuilder<SettingsCubit, Settingstate>(
                                  builder: (context, state) {
                                    final List<Cities> cities = context.read<SettingsCubit>().citiesList;
                                    return CustomCountryPicker(
                                      controller: countryController,
                                      onTap: () => _showCountryPicker(context, cities),
                                    );
                                  },
                                ),
                                SizedBox(height: screenHeight * 0.03),

                                // ---------------------- Logout ----------------------

                                Spacer(),

                                InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () => _showLogoutDialog(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.logout, color: Colors.white),
                                        SizedBox(width: 10),
                                        Text(
                                          'Log out',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ---------------------- أيقونة مميزة فوق الكارد ----------------------
                          Positioned(
                            top: -30,
                            left: screenWidth *0.4,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(Icons.settings, color: Colors.white, size: 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          )
          ,



        ));
  }

  void _showCountryPicker(BuildContext context, List<Cities> citiesList) {
    final items =
        citiesList.map((city) => SelectedListItem<Cities>(data: city)).toList();

    DropDownState<Cities>(
      dropDown: DropDown<Cities>(
          bottomSheetTitle: const Text(
            'Select City',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          submitButtonText: 'OK',
          clearButtonText: 'Clear',
          data: items,
          onSelected: (selectedItems) async {
            if (selectedItems.isNotEmpty) {
              final selectedCity = selectedItems.first.data;
              countryController.text = selectedCity.city;

              // عرض Loading Dialog
              _showLoadingDialog(context);

              // تحديث في الـ Cubit والـ Backend
              await context
                  .read<SettingsCubit>()
                  .updateCountryInBackEnd(city: selectedCity);
              print(
                               'Selected city: ${selectedCity.city}, id: ${selectedCity.id}');

              // إخفاء Loading Dialog بعد انتهاء العملية
              Navigator.of(context).pop();
            }
          }),
    ).showModal(context);
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // ❌ يمنع الضغط خارج الـ dialog
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("جاري التحديث..."),
            ],
          ),
        );
      },
    );
  }

  Widget buildCitiesShimmer() {
    return SizedBox(
      height: 60,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // void _showCountryPicker(BuildContext context, List<Cities> citiesList) {
  //   final items = citiesList
  //       .map((city) => SelectedListItem<Cities>(
  //             data: city,
  //           ))
  //       .toList();
  //
  //   DropDownState<Cities>(
  //     dropDown: DropDown<Cities>(
  //       bottomSheetTitle: const Text(
  //         'Select City',
  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
  //       ),
  //       submitButtonText: 'OK',
  //       clearButtonText: 'Clear',
  //       data: items,
  //       onSelected: (selectedItems) {
  //         if (selectedItems.isNotEmpty) {
  //           final selectedCity = selectedItems.first.data;
  //           countryController.text = selectedCity.city;
  //           context.read<SettingsCubit>().updateSelectedCity(selectedCity);
  //           context
  //               .read<SettingsCubit>()
  //               .updateCountryInBackEnd(city: selectedCity);
  //           print(
  //               'Selected city: ${selectedCity.city}, id: ${selectedCity.id}');
  //         }
  //       },
  //       enableMultipleSelection: false,
  //     ),
  //   ).showModal(context);
  // }

  // void _showLogoutDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (ctx) {
  //       return BlocConsumer<SettingsCubit, Settingstate>(
  //         listener: (context, state) {
  //           if (state is SettingLogoutSuccess) {
  //             Navigator.of(ctx).pop();
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
  //             );
  //           } else if (state is SettingLogoutFailure) {
  //             Navigator.of(ctx).pop();
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('خطأ: ${state.error}')),
  //             );
  //           }
  //         },
  //         builder: (context, state) {
  //           final isLoading = state is SettingLogoutLoading;
  //
  //           return AlertDialog(
  //             title: const Text('تأكيد تسجيل الخروج'),
  //             content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
  //             actions: [
  //               TextButton(
  //                 onPressed: isLoading ? null : () => Navigator.of(ctx).pop(),
  //                 child: const Text('إلغاء'),
  //               ),
  //               isLoading
  //                   ? const SizedBox(
  //                       height: 24,
  //                       width: 24,
  //                       child: CircularProgressIndicator(strokeWidth: 2),
  //                     )
  //                   : ElevatedButton(
  //                       onPressed: () {
  //                         context.read<SettingsCubit>().logout();
  //                       },
  //                       child: const Text('تأكيد'),
  //                     ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (ctx) {
        return BlocConsumer<SettingsCubit, Settingstate>(
          listener: (context, state) async {
            if (state is SettingLogoutSuccess) {
              // On success, show a new AlertDialog
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx2) {
                  return WillPopScope(
                    onWillPop: () async => false, // منع زر الرجوع
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        'Success',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        state.message, // Success message from SettingLogoutSuccess
                        style: const TextStyle(fontSize: 16),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx2).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => SignIn(), // ضع هنا صفحة الـ Login الخاصة بك
                              ),
                                  (route) => false, // هذا يضمن إزالة كل الصفحات السابقة
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is SettingLogoutFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is SettingLogoutLoading;

            return WillPopScope(
              onWillPop: () async => false, // منع زر الرجوع
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                title: const Text(
                  'Confirm Logout',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                content: SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                actions: [
                  TextButton(
                    onPressed: isLoading ? null : () => Navigator.of(ctx).pop(),
                    child: const Text('Cancel'),
                  ),
                  isLoading
                      ? SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  )
                      : ElevatedButton(
                    onPressed: () {
                      context.read<SettingsCubit>().logout();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  Widget _buildSettingCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[850]
          : const Color.fromARGB(255, 218, 234, 241),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
