//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ThemeCubit extends Cubit<ThemeData> {
//   ThemeCubit() : super(_lightTheme);
//
//   // الثيم الفاتح مع ألوان متعددة
//   static final ThemeData _lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: Colors.blue,
//     colorScheme: ColorScheme.light(
//       primary: Colors.blue,
//       secondary: Colors.green,
//       tertiary: Colors.orange,
//     ),
//   );
//
//   // الثيم المظلم مع ألوان متعددة
//   static final ThemeData _darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: Colors.blueGrey,
//     colorScheme: ColorScheme.dark(
//       primary: Colors.blueGrey,
//       secondary: Colors.deepPurple,
//       tertiary: Colors.redAccent,
//     ),
//   );
//
//   void toggleTheme() {
//     emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/theme_cubit/themeState.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.system));

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeState(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDarkMode);
    emit(ThemeState(themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }
}

