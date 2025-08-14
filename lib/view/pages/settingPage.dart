import 'dart:async';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
        body: ListView(padding: const EdgeInsets.all(20), children: [
      SwitchListTile(
        title: const Text("الوضع الليلي"),
        value: context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark,
        onChanged: (val) {
          context.read<ThemeCubit>().toggleTheme(val);
        },
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //   child: Builder(
      //     builder: (context) {
      //       final isDark = context.select<ThemeCubit, bool>(
      //             (cubit) => cubit.state.themeMode == ThemeMode.dark,
      //       );
      //
      //       return Container(
      //         height: 65, // نفس حجم الكارد تقريبًا
      //         decoration: BoxDecoration(
      //           gradient: LinearGradient(
      //             colors: isDark
      //                 ? [Colors.blueGrey.shade900, Colors.black87]
      //                 : [Colors.blue.shade100, Colors.white],
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //           ),
      //           borderRadius: BorderRadius.circular(15),
      //           boxShadow: [
      //             BoxShadow(
      //               color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.3),
      //               blurRadius: 12,
      //               offset: const Offset(0, 6),
      //             ),
      //           ],
      //         ),
      //         child: SwitchListTile.adaptive(
      //           title: Text(
      //             "الوضع الليلي",
      //             style: Theme.of(context).textTheme.titleMedium?.copyWith(
      //               fontWeight: FontWeight.bold,
      //               color: isDark ? Colors.white : Colors.black87,
      //             ),
      //           ),
      //           secondary: AnimatedSwitcher(
      //             duration: const Duration(milliseconds: 400),
      //             transitionBuilder: (child, anim) =>
      //                 RotationTransition(turns: anim, child: child),
      //             child: Icon(
      //               isDark ? Icons.nightlight_round : Icons.wb_sunny,
      //               key: ValueKey(isDark),
      //               color:
      //               isDark ? Colors.yellow.shade600 : Colors.orange.shade700,
      //               size: 26,
      //             ),
      //           ),
      //           value: isDark,
      //           onChanged: (val) {
      //             context.read<ThemeCubit>().toggleTheme(val);
      //           },
      //         ),
      //       );
      //     },
      //   ),
      // ),

      const SizedBox(height: 12),

      // BlocBuilder<SettingsCubit, Settingstate>(
      //   builder: (context, state) {
      //     final List<Cities> cities = context.read<SettingsCubit>().citiesList;
      //
      //     return CustomCountryPicker(
      //       controller: countryController,
      //       onTap: () =>
      //           _showCountryPicker(context, cities), // ✅ مرر البيانات هنا
      //     );
      //   },
      // ),

      // BlocBuilder<SettingsCubit, Settingstate>(
      //   builder: (context, state) {
      //     if (state is SettingLoading && context.read<SettingsCubit>().citiesList.isEmpty) {
      //       // عرض Shimmer أثناء تحميل المدن لأول مرة
      //       return buildCitiesShimmer();
      //     }
      //
      //     final List<Cities> cities = context.read<SettingsCubit>().citiesList;
      //     return CustomCountryPicker(
      //       controller: countryController,
      //       onTap: () => _showCountryPicker(context, cities),
      //     );
      //   },
      // ),

      // BlocBuilder<SettingsCubit, Settingstate>(
      //   builder: (context, state) {
      //     if (state is SettingLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is SettingSuccess) {
      //       final selectedCity = state.selectedCity;
      //       countryController.text = selectedCity?.city ?? '';
      //
      //       return CustomCountryPicker(
      //         controller: countryController,
      //         onTap: () => _showCountryPicker(context, state.cities),
      //       );
      //     }
      //     return const SizedBox();
      //   },
      // ),

          BlocBuilder<SettingsCubit, Settingstate>(
            builder: (context, state) {
              if (state is SettingLoading) {
                // 🎯 عرض كرة أرضية متحركة بدل مؤشر التحميل التقليدي
                return Center(
                  child: Lottie.asset(
                    'assets/animations/rotating_globe.json', // ضع ملفك هنا
                    width: 80,
                    height: 80,
                    repeat: true,
                  ),
                );
              }
              else if (state is SettingSuccess) {
                final selectedCity = state.selectedCity;
                countryController.text = selectedCity?.city ?? '';

                return CustomCountryPicker(
                  controller: countryController,
                  onTap: () => _showCountryPicker(context, state.cities),
                );
              }
              return const SizedBox();
            },
          ),


          const SizedBox(height: 12),

      Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _showLogoutDialog(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )))
    ]));
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
        return AlertDialog(
          content: Row(
            children: const [
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return BlocConsumer<SettingsCubit, Settingstate>(
          listener: (context, state) {
            if (state is SettingLogoutSuccess) {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
              );
            } else if (state is SettingLogoutFailure) {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('خطأ: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is SettingLogoutLoading;

            return AlertDialog(
              title: const Text('تأكيد تسجيل الخروج'),
              content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () => Navigator.of(ctx).pop(),
                  child: const Text('إلغاء'),
                ),
                isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          context.read<SettingsCubit>().logout();
                        },
                        child: const Text('تأكيد'),
                      ),
              ],
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
