// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gaagls/controller/cubits/EditBookingCubit/editBookingCubit.dart';
// import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
// import 'package:gaagls/controller/cubits/RoomBookingCubit/RoomBookingCubit.dart';
// import 'package:gaagls/controller/cubits/airlineCubit/airlineCubit.dart';
// import 'package:gaagls/controller/cubits/bookingCubit/bookingCubit.dart';
// import 'package:gaagls/controller/cubits/carBrandCubit/carBrandCubit.dart';
// import 'package:gaagls/controller/cubits/carDetailsCubit/carDetailsCubit.dart';
// import 'package:gaagls/controller/cubits/carScreenCubit/carScreenCubit.dart';
// import 'package:gaagls/controller/cubits/destinationCubit/destinationCubit.dart';
// import 'package:gaagls/controller/cubits/favoriteCubit/favoriteCubit.dart';
// import 'package:gaagls/controller/cubits/homeCubit/homeCubit.dart';
// import 'package:gaagls/controller/cubits/hotelsCubit/hotelsCubit.dart';
// import 'package:gaagls/controller/cubits/logInCubit/logInCubit.dart';
// import 'package:gaagls/controller/cubits/otp_cubit/otp_cubit.dart';
// import 'package:gaagls/controller/cubits/profileCubit/profileCubit.dart';
// import 'package:gaagls/controller/cubits/reserveTripCubit/reserveTripCubit.dart';
// import 'package:gaagls/controller/cubits/roomCubit/roomCubit.dart';
// import 'package:gaagls/controller/cubits/searchCubit/searchCubit.dart';
// import 'package:gaagls/controller/cubits/signUpCubit/registerCubit.dart';
// import 'package:gaagls/controller/cubits/tripCubit/tripCubit.dart';
// import 'package:gaagls/view/pages/bookingsPage.dart';
// import 'package:gaagls/view/pages/customNavBar.dart';
// import 'package:gaagls/view/pages/signIn_Page.dart';
// import 'controller/cubits/theme_cubit/theme_cubit.dart';
//
//
//
// void main() {
//   runApp(
//       MultiBlocProvider(
//           providers: [
//             BlocProvider(create: (context) => ThemeCubit()),
//             BlocProvider(create: (context) => RegisterCubit()),
//             BlocProvider(create: (context) => LoginCubit()),
//             BlocProvider(create: (context) => OtpCubit()),
//             BlocProvider(create: (context) => NavCubit()),
//             BlocProvider(create: (context) => HomeCubit()),
//             BlocProvider(create: (context) => RestaurantsCubit()),
//             BlocProvider(create: (context) => HotelsCubit()),
//             BlocProvider(create: (context) => RoomsCubit()),
//             BlocProvider(create: (context) => RoomBookingCubit()),
//             BlocProvider(create: (context) => TripReserveCubit()),
//             BlocProvider(create: (context) => TripsCubit()),
//             BlocProvider(create: (context) => CarsCubit()),
//             BlocProvider(create: (context) => CarBrandsCubit()),
//             BlocProvider(create: (context) => CarDetailsCubit(initialIndex: 0,carsLength: 1)),
//             BlocProvider(create: (context) => AirLinesCubit()),
//             BlocProvider(create: (context) => SearchCubit()),
//             BlocProvider(create: (context) => DestinationsCubit()),
//             BlocProvider(create: (context) => FavoriteCubit()),
//             BlocProvider(create: (context) => ProfileCubit()),
//             BlocProvider(create: (context) => BookingsCubit()),
//             BlocProvider(create: (context) => Editbookingcubit()),
//           ],
//           child: const MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, ThemeData>(
//       builder: (context, theme) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: theme,
//           home: CustomNavBar(), // تأكد من تعريف `HomeScreen`
//         );
//       },
//     );
//   }
// }
//
//



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/EditBookingCubit/editBookingCubit.dart';
import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
import 'package:gaagls/controller/cubits/RoomBookingCubit/RoomBookingCubit.dart';
import 'package:gaagls/controller/cubits/airlineCubit/airlineCubit.dart';
import 'package:gaagls/controller/cubits/bookingCubit/bookingCubit.dart';
import 'package:gaagls/controller/cubits/carBrandCubit/carBrandCubit.dart';
import 'package:gaagls/controller/cubits/carDetailsCubit/carDetailsCubit.dart';
import 'package:gaagls/controller/cubits/carScreenCubit/carScreenCubit.dart';
import 'package:gaagls/controller/cubits/destinationCubit/destinationCubit.dart';
import 'package:gaagls/controller/cubits/favoriteCubit/favoriteCubit.dart';
import 'package:gaagls/controller/cubits/homeCubit/homeCubit.dart';
import 'package:gaagls/controller/cubits/hotelsCubit/hotelsCubit.dart';
import 'package:gaagls/controller/cubits/logInCubit/logInCubit.dart';
import 'package:gaagls/controller/cubits/otp_cubit/otp_cubit.dart';
import 'package:gaagls/controller/cubits/profileCubit/profileCubit.dart';
import 'package:gaagls/controller/cubits/reserveTripCubit/reserveTripCubit.dart';
import 'package:gaagls/controller/cubits/roomCubit/roomCubit.dart';
import 'package:gaagls/controller/cubits/searchCubit/searchCubit.dart';
import 'package:gaagls/controller/cubits/settingCubit/settingCubit.dart';
import 'package:gaagls/controller/cubits/signUpCubit/registerCubit.dart';
import 'package:gaagls/controller/cubits/tripCubit/tripCubit.dart';
import 'package:gaagls/view/pages/customNavBar.dart';
import 'package:gaagls/view/pages/signIn_Page.dart';
import 'controller/cubits/theme_cubit/myTheme.dart';
import 'controller/cubits/theme_cubit/themeState.dart';
import 'controller/cubits/theme_cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme(); // تحميل الوضع من SharedPreferences

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeCubit),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => OtpCubit()),
        BlocProvider(create: (context) => NavCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => RestaurantsCubit()),
        BlocProvider(create: (context) => HotelsCubit()),
        BlocProvider(create: (context) => RoomsCubit()),
        BlocProvider(create: (context) => RoomBookingCubit()),
        BlocProvider(create: (context) => TripReserveCubit()),
        BlocProvider(create: (context) => TripsCubit()),
        BlocProvider(create: (context) => CarsCubit()),
        BlocProvider(create: (context) => CarBrandsCubit()),
        BlocProvider(create: (context) => CarDetailsCubit(initialIndex: 0, carsLength: 1)),
        BlocProvider(create: (context) => AirLinesCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => DestinationsCubit()),
        BlocProvider(create: (context) => FavoriteCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => BookingsCubit()),
        BlocProvider(create: (context) => Editbookingcubit()),
        BlocProvider(create: (context) => SettingsCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: state.themeMode,
          home: SignIn(),
        );
      },
    );
  }
}
