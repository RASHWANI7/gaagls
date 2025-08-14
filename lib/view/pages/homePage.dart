import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:gaagls/view/widgets/carBrandCard.dart';
import 'package:gaagls/view/widgets/destinationCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    // ✅ استدعِ التابع مرة واحدة عند فتح الصفحة
    Future.microtask(() {
      context.read<HomeCubit>().loadHomeData();
    });
  }



  @override
  Widget build(BuildContext context) {


    final sectionTitleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );

    final seeAlleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color:  Theme.of(context).primaryColor,
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final destinationCardWidth = screenWidth * 0.35;
    final destinationImageHeight = destinationCardWidth * 0.9;

    final tripCardWidth = screenWidth * 0.6;
    final tripImageHeight = tripCardWidth * 0.9;

    final hotelCardWidth = screenWidth * 0.6;
    final hotelImageHeight = hotelCardWidth * 0.7;

    final restaurantCardWidth = screenWidth * 0.45;
    final restaurantImageHeight = restaurantCardWidth * 0.9;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(8,5,8,80),
                children: const [
                  ShimmerCategoryList(title: 'Categories',),
                  ShimmerSection(title: "Destinations", itemType: "destination"),
                  ShimmerSection(title: "Trips", itemType: "trip"),
                  ShimmerSection(title: "Hotels", itemType: "hotel"),
                  ShimmerSection(title: "Resturants", itemType: "restaurant"),
                  //ShimmerSection(title: "Cars", itemType: "car"),
                  ShimmerCategoryList(title: 'Cars',)
                ],
              );
            }
            if (state.error != null) {
              print(state.error);
              return Center(child: Text('حدث خطأ: ${state.error}'));
            }
            if (state.data != null) {
              final destinations = state.data!.destinations;
              final trips = state.data!.trips;
              final hotels = state.data!.hotels;
              final restaurants = state.data!.restaurants;
              final carsBrand = state.data!.carsBrand;

              return ListView(
                padding: const EdgeInsets.fromLTRB(8,5,8,0),
                children: [

                  const CategoryList(),

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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DestinationsPage()));
                            },
                            child: Text(
                              'see all',
                              style: seeAlleStyle,
                            ))
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: destinationImageHeight+50, // يجب تحديد الارتفاع هنا
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          final destination = destinations[index];
                          return DestinationCard(
                            destination: destination,
                            width: destinationCardWidth,
                            imageHeight: destinationImageHeight,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AirLinesPage(destination: destination,),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],

                  if (trips.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Trips",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TripsPage()));
                            },
                            child: Text(
                              'see all',
                              style: seeAlleStyle,
                            ))
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: tripImageHeight + 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: trips.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final trip = trips[index];
                          return TripCard(
                            trip: trip,
                            width: tripCardWidth,
                            imageHeight: tripImageHeight,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TripDetailsPage(trip: trip),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],

                  if (hotels.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hotels ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HotelsPage()));
                            },
                            child: Text(
                              'see all',
                              style: seeAlleStyle,
                            ))
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: hotelImageHeight + 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hotels.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final hotel = hotels[index];
                          return HotelCard(
                            hotel: hotel,
                            width: hotelCardWidth,
                            imageHeight: hotelImageHeight,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RoomsPage(hotel: hotel),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],

                  if (restaurants.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Resturants",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResturantsPage()));
                            },
                            child: Text(
                              'see all',
                              style: seeAlleStyle,
                            ))
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: restaurantImageHeight + 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurants.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final resturant = restaurants[index];
                          return RestaurantCard(
                            resturant: resturant,
                            width: restaurantCardWidth,
                            imageHeight: restaurantImageHeight,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ResturantDetailsPage(
                                      resturant: resturant),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],

                  if (carsBrand.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Cars",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CarBrandPage()));
                            },
                            child: Text(
                              'see all',
                              style: seeAlleStyle,
                            ))
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: tripImageHeight ,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: carsBrand.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          final carbrand = carsBrand[index];
                          return CarBrandCard(
                            brand: carbrand,
                            onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=> CarsPage(brandName: carbrand.brandName)));
                            },
                          );
                        },
                      ),
                    ),
                  ]

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
