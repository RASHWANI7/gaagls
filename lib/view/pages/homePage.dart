// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gaagls/view/pages/airlinePage.dart';
// import 'package:gaagls/view/pages/carBrandPage.dart';
// import 'package:gaagls/view/pages/carsPage.dart';
// import 'package:gaagls/view/pages/destinationsPage.dart';
// import 'package:gaagls/view/pages/hotelsPage.dart';
// import 'package:gaagls/view/pages/resturantDetailsPage.dart';
// import 'package:gaagls/view/pages/resturantsPage.dart';
// import 'package:gaagls/view/pages/roomsPage.dart';
// import 'package:gaagls/view/pages/tripDetailsPage.dart';
// import 'package:gaagls/view/pages/tripsPage.dart';
// import '../../controller/cubits/homeCubit/homeCubit.dart';
// import '../../controller/cubits/homeCubit/homeState.dart';
// import '../widgets/carBrandCard.dart';
// import '../widgets/categoryItem.dart';
// import '../widgets/destinationCard.dart';
// import '../widgets/shimmerCategoryList.dart';
// import '../widgets/shimmerSection.dart';
// import 'package:gaagls/view/widgets/hotelCard.dart';
// import 'package:gaagls/view/widgets/resturantCard.dart';
// import 'package:gaagls/view/widgets/tripCard.dart';
// import 'package:gaagls/view/widgets/carBrandCard.dart';
// import 'package:gaagls/view/widgets/destinationCard.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     // ✅ استدعِ التابع مرة واحدة عند فتح الصفحة
//     Future.microtask(() {
//       context.read<HomeCubit>().loadHomeData();
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final sectionTitleStyle = const TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.bold,
//       color: Colors.blueGrey,
//     );
//
//     final seeAlleStyle = TextStyle(
//       fontSize: 15,
//       fontWeight: FontWeight.bold,
//       color:  Theme.of(context).primaryColor,
//     );
//
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     final destinationCardWidth = screenWidth * 0.35;
//     final destinationImageHeight = destinationCardWidth * 0.9;
//
//     final tripCardWidth = screenWidth * 0.6;
//     final tripImageHeight = tripCardWidth * 0.9;
//
//     final hotelCardWidth = screenWidth * 0.6;
//     final hotelImageHeight = hotelCardWidth * 0.7;
//
//     final restaurantCardWidth = screenWidth * 0.45;
//     final restaurantImageHeight = restaurantCardWidth * 0.9;
//
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return ListView(
//                 padding: const EdgeInsets.fromLTRB(8,5,8,80),
//                 children: const [
//                   ShimmerCategoryList(title: 'Categories',),
//                   ShimmerSection(title: "Destinations", itemType: "destination"),
//                   ShimmerSection(title: "Trips", itemType: "trip"),
//                   ShimmerSection(title: "Hotels", itemType: "hotel"),
//                   ShimmerSection(title: "Resturants", itemType: "restaurant"),
//                   //ShimmerSection(title: "Cars", itemType: "car"),
//                   ShimmerCategoryList(title: 'Cars',)
//                 ],
//               );
//             }
//             if (state.error != null) {
//               print(state.error);
//               return Center(child: Text('حدث خطأ: ${state.error}'));
//             }
//             if (state.data != null) {
//               final destinations = state.data!.destinations;
//               final trips = state.data!.trips;
//               final hotels = state.data!.hotels;
//               final restaurants = state.data!.restaurants;
//               final carsBrand = state.data!.carsBrand;
//
//               return ListView(
//                 padding: const EdgeInsets.fromLTRB(8,5,8,0),
//                 children: [
//
//                   const CategoryList(),
//
//                   if (destinations.isNotEmpty) ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Destinations",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const DestinationsPage()));
//                             },
//                             child: Text(
//                               'see all',
//                               style: seeAlleStyle,
//                             ))
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: destinationImageHeight+50, // يجب تحديد الارتفاع هنا
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: destinations.length,
//                         itemBuilder: (context, index) {
//                           final destination = destinations[index];
//                           return DestinationCard(
//                             destination: destination,
//                             width: destinationCardWidth,
//                             imageHeight: destinationImageHeight,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => AirLinesPage(destination: destination,),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//
//                   if (trips.isNotEmpty) ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Trips",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const TripsPage()));
//                             },
//                             child: Text(
//                               'see all',
//                               style: seeAlleStyle,
//                             ))
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: tripImageHeight + 100,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: trips.length,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemBuilder: (context, index) {
//                           final trip = trips[index];
//                           return TripCard(
//                             trip: trip,
//                             width: tripCardWidth,
//                             imageHeight: tripImageHeight,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => TripDetailsPage(trip: trip),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//
//                   if (hotels.isNotEmpty) ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Hotels ",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const HotelsPage()));
//                             },
//                             child: Text(
//                               'see all',
//                               style: seeAlleStyle,
//                             ))
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: hotelImageHeight + 100,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: hotels.length,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemBuilder: (context, index) {
//                           final hotel = hotels[index];
//                           return HotelCard(
//                             hotel: hotel,
//                             width: hotelCardWidth,
//                             imageHeight: hotelImageHeight,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => RoomsPage(hotel: hotel),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//
//                   if (restaurants.isNotEmpty) ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Resturants",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const ResturantsPage()));
//                             },
//                             child: Text(
//                               'see all',
//                               style: seeAlleStyle,
//                             ))
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: restaurantImageHeight + 120,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: restaurants.length,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemBuilder: (context, index) {
//                           final resturant = restaurants[index];
//                           return RestaurantCard(
//                             resturant: resturant,
//                             width: restaurantCardWidth,
//                             imageHeight: restaurantImageHeight,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => ResturantDetailsPage(
//                                       resturant: resturant),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//
//                   if (carsBrand.isNotEmpty) ...[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Cars",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const CarBrandPage()));
//                             },
//                             child: Text(
//                               'see all',
//                               style: seeAlleStyle,
//                             ))
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       height: tripImageHeight ,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: carsBrand.length,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         itemBuilder: (context, index) {
//                           final carbrand = carsBrand[index];
//                           return CarBrandCard(
//                             brand: carbrand,
//                             onTap: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CarsPage(brandName: carbrand.brandName)));
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ]
//
//                 ],
//               );
//             }
//             return const Center(child: Text("لا توجد بيانات."));
//           },
//         ),
//       ),
//     );
//   }
// }






import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gaagls/globals/globals.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import 'package:gaagls/view/pages/airlinePage.dart';
import 'package:gaagls/view/pages/carBrandPage.dart';
import 'package:gaagls/view/pages/carsPage.dart';
import 'package:gaagls/view/pages/destinationsPage.dart';
import 'package:gaagls/view/pages/hotelsPage.dart';
import 'package:gaagls/view/pages/resturantDetailsPage.dart';
import 'package:gaagls/view/pages/resturantsPage.dart';
import 'package:gaagls/view/pages/roomsPage.dart';
import 'package:gaagls/view/pages/tripDetailsPage.dart';
import 'package:gaagls/view/pages/tripsPage.dart';
import '../../controller/cubits/homeCubit/homeCubit.dart';
import '../../controller/cubits/homeCubit/homeState.dart';
import '../widgets/carBrandCard.dart';
import '../widgets/categoryItem.dart';
import '../widgets/destinationCard.dart';
import '../widgets/shimmerCategoryList.dart';
import '../widgets/shimmerSection.dart';
import 'package:gaagls/view/widgets/hotelCard.dart';
import 'package:gaagls/view/widgets/resturantCard.dart';
import 'package:gaagls/view/widgets/tripCard.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../controller/cubits/homeCubit/homeCubit.dart';
import '../../controller/cubits/homeCubit/homeState.dart';
import '../widgets/categoryItem.dart';
import '../widgets/destinationCard.dart';
import '../widgets/shimmerCategoryList.dart';
import '../widgets/shimmerSection.dart';
import 'airlinePage.dart';
import 'destinationsPage.dart';

class HomePage extends StatefulWidget {
  final int id;
  const HomePage({super.key,required this.id});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _fcmToken; // ✅ متغير لتخزين التوكن

  @override
  void initState() {
    super.initState();

    // استدعاء Cubit + FCM عند فتح الصفحة
    Future.microtask(() {
      context.read<HomeCubit>().loadHomeData();
      _initFCM();
    });
  }

  Future<void> _initFCM() async {
    // طلب إذن الإشعارات (Android 13+)
    if (Platform.isAndroid && await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // الحصول على التوكن
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("📌 FCM Token: $token");

    if (mounted) {
      setState(() => _fcmToken = token);
    }

    if (token != null) {
      await _sendTokenToServer(token);
    }

    // تحديث التوكن إذا تغيّر
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      if (mounted) {
        setState(() => _fcmToken = newToken);
      }
      _sendTokenToServer(newToken);
    });

    // استقبال إشعار في foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("📩 رسالة جديدة: ${message.notification?.title}");
    });
  }

  Future<void> _sendTokenToServer(String token) async {
    try {
      final url = Uri.parse('${Globals().ngrok}/deviceToken/${widget.id}'); // عدّل الرابط
      await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
        }),
      );
      debugPrint("✅ Token sent to backend");
    } catch (e) {
      debugPrint("❌ Failed to send token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final seeAlleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final destinationCardWidth = screenWidth * 0.35;
    final destinationImageHeight = destinationCardWidth * 0.9;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 80),
                children: const [
                  ShimmerCategoryList(title: 'Categories'),
                  ShimmerSection(title: "Destinations", itemType: "destination"),
                  ShimmerSection(title: "Trips", itemType: "trip"),
                  ShimmerSection(title: "Hotels", itemType: "hotel"),
                  ShimmerSection(title: "Resturants", itemType: "restaurant"),
                  ShimmerCategoryList(title: 'Cars'),
                ],
              );
            }
            if (state.error != null) {
              return Center(child: Text('حدث خطأ: ${state.error}'));
            }
            if (state.data != null) {
              final destinations = state.data!.destinations;

              return ListView(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                children: [
                  const CategoryList(),

                  // ✅ عرض التوكن (اختياري للتجربة فقط)
                  if (_fcmToken != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("📌 Token: $_fcmToken"),
                    ),

                  if (destinations.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Destinations",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const DestinationsPage()),
                          ),
                          child: Text('see all', style: seeAlleStyle),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: destinationImageHeight + 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          final destination = destinations[index];
                          return DestinationCard(
                            destination: destination,
                            width: destinationCardWidth,
                            imageHeight: destinationImageHeight,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AirLinesPage(destination: destination),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              );
            }
            return const Center(child: Text("لا توجد بيانات."));
          },
        ),
      ),
    );
  }
}
