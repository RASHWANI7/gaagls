// // import 'package:flutter/material.dart';
// //
// // class MyThemes {
// //   static const Color primaryColor = Color(0xFF1976D2); // لون أساسي ثابت
// //   static const Color secondaryColor = Color(0xFF42A5F5); // لون ثانوي ثابت
// //
// //   static final ThemeData lightTheme = ThemeData(
// //     brightness: Brightness.light,
// //     primaryColor: primaryColor,
// //     scaffoldBackgroundColor: Colors.white,
// //     appBarTheme: const AppBarTheme(
// //       backgroundColor: primaryColor,
// //       foregroundColor: Colors.white,
// //     ),
// //     elevatedButtonTheme: ElevatedButtonThemeData(
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: primaryColor,
// //         foregroundColor: Colors.white,
// //       ),
// //     ),
// //     colorScheme: ColorScheme.light(
// //       primary: primaryColor,
// //       secondary: secondaryColor,
// //     ),
// //   );
// //
// //   static final ThemeData darkTheme = ThemeData(
// //     brightness: Brightness.dark,
// //     primaryColor: primaryColor,
// //     scaffoldBackgroundColor: const Color(0xFF121212),
// //     appBarTheme: const AppBarTheme(
// //       backgroundColor: primaryColor,
// //       foregroundColor: Colors.white,
// //     ),
// //     elevatedButtonTheme: ElevatedButtonThemeData(
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: primaryColor,
// //         foregroundColor: Colors.white,
// //       ),
// //     ),
// //     colorScheme: ColorScheme.dark(
// //       primary: primaryColor,
// //       secondary: secondaryColor,
// //     ),
// //   );
// // }
//
//
//
//
// import 'package:flutter/material.dart';
//
// class MyThemes {
//   static const Color primaryColor = Color(0xFF0b47a0); // أزرق غامق
//   static const Color secondaryColor = Color(0xFF1362bb); // أزرق فاتح
//   static const Color backgroundLight = Colors.white;
//   static  Color backgroundDark = Colors.red;
//   static const Color textDark = Colors.white;
//   static const Color textLight = Colors.black87;
//   static const Color cardLight = Colors.white;
//   static const Color cardDark = Color(0xFF1E1E1E);
//
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primaryColor: primaryColor,
//     scaffoldBackgroundColor: backgroundLight,
//     cardColor: cardLight,
//     iconTheme: const IconThemeData(color: Colors.black54),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 2,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: textLight),
//       bodyMedium: TextStyle(color: textLight),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey.shade100,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade400),
//       ),
//     ),
//     colorScheme: ColorScheme.light(
//       primary: primaryColor,
//       secondary: secondaryColor,
//       surface: backgroundLight,
//       onPrimary: Colors.white,
//       onBackground: textLight,
//     ),
//   );
//
//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: primaryColor,
//     scaffoldBackgroundColor: backgroundDark,
//     cardColor: cardDark,
//     iconTheme: const IconThemeData(color: Colors.white70),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: primaryColor,
//       foregroundColor: Colors.white,
//       elevation: 2,
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: textDark),
//       bodyMedium: TextStyle(color: textDark),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey.shade800,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade600),
//       ),
//     ),
//     colorScheme: ColorScheme.dark(
//       primary: primaryColor,
//       secondary: secondaryColor,
//       surface: backgroundDark,
//       onPrimary: Colors.white,
//       onBackground: textDark,
//     ),
//   );
// }
//



import 'package:flutter/material.dart';

class MyThemes {
  static const Color primaryColor = Color(0xFF0b47a0);
  static const Color secondaryColor = Color(0xFF1362bb);

  static  Color backgroundLight = Colors.grey.shade400;
  static  Color backgroundDark = Colors.grey.shade900;

  static const Color textLight = Colors.black87;
  static const Color textDark = Colors.white;

  static  Color cardLight = Colors.grey.shade300;
  static  Color cardDark = Colors.grey.shade800;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    iconTheme: const IconThemeData(color: Colors.black54),

    // نصوص تعتمد على اللون على الخلفية (onBackground)
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textLight),
      bodyMedium: TextStyle(color: textLight),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    ),

    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardLight,
      background: backgroundLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textLight,
      onBackground: textLight,
      error: Colors.red,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    iconTheme: const IconThemeData(color: Colors.white70),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textDark),
      bodyMedium: TextStyle(color: textDark),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
    ),

    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardDark,
      background: backgroundDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textDark,
      onBackground: textDark,
      error: Colors.red,
    ),
  );
}

