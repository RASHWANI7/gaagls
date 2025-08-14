// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gaagls/view/pages/resturantDetailsPage.dart';
// import 'package:gaagls/view/pages/roomsPage.dart';
// import 'package:gaagls/view/pages/tripDetailsPage.dart';
// import 'package:gaagls/view/widgets/destinationPageCard.dart';
// import '../../controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
// import '../../controller/cubits/carScreenCubit/carScreenCubit.dart';
// import '../../controller/cubits/favoriteCubit/favoriteCubit.dart';
// import '../../controller/cubits/favoriteCubit/favoriteState.dart';
// import '../../controller/cubits/hotelsCubit/hotelsCubit.dart';
// import '../../main.dart';
// import '../widgets/carPageCard.dart';
// import '../widgets/hotelPageCard.dart';
// import '../widgets/resturantFavoriteCard.dart';
// import '../widgets/resturantPageCard.dart';
// import '../widgets/secondSnackBar.dart';
// import '../widgets/tripPageCard.dart';
// import '../widgets/destinationCard.dart';
// import 'airlinePage.dart';
// import 'carDetailsPage.dart';
//
// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});
//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }
//
// class _FavoritePageState extends State<FavoritePage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<FavoriteCubit>().getFavorites();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<FavoriteCubit, FavoriteState>(
//         builder: (ctx, state) {
//           if (state is FavoriteLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is FavoriteFailure) {
//             return Center(child: Text('Error: ${state.error}'));
//           }
//           if (state is FavoriteSuccess) {
//             final sections = <Widget>[];
//
//             if (state.restaurants.isNotEmpty) {
//               sections.add(const SectionTitle('Restaurants'));
//               sections.addAll(state.restaurants.map((r) =>
//                   RestaurantPageCard(
//                     resturant: r,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               ResturantDetailsPage(resturant: r),
//                         ),
//                       );
//                     },
//                     onFavoriteTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleRestaurantFavorite(r);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if (state.hotels.isNotEmpty) {
//               sections.add(const SectionTitle('Hotels'));
//               sections.addAll(state.hotels.map((h) =>
//                   HotelPageCard(
//                     hotel: h,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => RoomsPage(hotel: h),
//                         ),
//                       );
//                     },
//                     onFavotieTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleHotelFavorite(h);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if (state.trips.isNotEmpty) {
//               sections.add(const SectionTitle('Trips'));
//               sections.addAll(state.trips.map((t) =>
//                   TripPageCard(
//                     trip: t,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               TripDetailsPage(trip: t),
//                         ),
//                       );
//                     },
//                     onFavoriteTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleTripFavorite(t);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if (state.destinations.isNotEmpty) {
//               sections.add(const SectionTitle('Destinations'));
//               sections.addAll(state.destinations.map((d) =>
//                   DestinationPageCard(
//                     destination: d,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => AirLinesPage(destination: d),
//                         ),
//                       );
//                     },
//                     onFavoriteTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleDestinationFavorite(d);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if (state.cars.isNotEmpty) {
//               sections.add(const SectionTitle('Cars'));
//
//               sections.addAll(state.cars.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final c = entry.value;
//
//                 return CarPageCard(
//                   car: c,
//                   width: double.infinity,
//                   imageHeight: 200,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => CarDetailsPage(
//                           cars: state.cars,       // القائمة الكاملة للسيارات المفضلة
//                           initialIndex: index,    // الفهرس الحالي داخل القائمة
//                           companyName: c.brand,   // أو أي قيمة تريد عرضها كعنوان
//                         ),
//                       ),
//                     );
//                   },
//                   onFavoriteTap: () async {
//                     final result = await context.read<FavoriteCubit>().toggleCarFavorite(c);
//                     SecondSnackBar(
//                       result['message'],
//                       context,
//                       isError: !result['success'],
//                     );
//                   },
//                 );
//               }));
//             }
//
//
//
//             if (sections.isEmpty) {
//               return const Center(child: Text('No favorites yet.'));
//             }
//             return ListView(padding: const EdgeInsets.all(8), children: sections);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
//
// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle(this.title, {super.key});
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//     child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//   );
// }
//
// /// امتداد لإضافة زر مفضل إلى أي بطاقة
// extension TrailingCard on Widget {
//   Widget withTrailing(Widget trailing) {
//     return Stack(
//       children: [
//         this,
//         Positioned(top: 8, right: 8, child: trailing),
//       ],
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../controller/cubits/favoriteCubit/favoriteCubit.dart';
// import '../../controller/cubits/favoriteCubit/favoriteState.dart';
// import '../widgets/carPageCard.dart';
// import '../widgets/destinationPageCard.dart';
// import '../widgets/hotelPageCard.dart';
// import '../widgets/resturantFavoriteCard.dart';
// import '../widgets/resturantPageCard.dart';
// import '../widgets/secondSnackBar.dart';
// import '../widgets/tripPageCard.dart';
// import '../widgets/destinationCard.dart';
// import 'carDetailsPage.dart';
// import 'resturantDetailsPage.dart';
// import 'roomsPage.dart';
// import 'tripDetailsPage.dart';
// import 'airlinePage.dart';
//
// class FavoritePage extends StatelessWidget {
//   const FavoritePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: (filter) {
//               context.read<FavoriteCubit>().changeFilter(filter);
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(value: 'all', child: Text('All')),
//               const PopupMenuItem(value: 'cars', child: Text('Cars')),
//               const PopupMenuItem(value: 'hotels', child: Text('Hotels')),
//               const PopupMenuItem(value: 'restaurants', child: Text('Restaurants')),
//               const PopupMenuItem(value: 'trips', child: Text('Trips')),
//               const PopupMenuItem(value: 'destinations', child: Text('Destinations')),
//             ],
//           )
//         ],
//       ),
//       body: BlocBuilder<FavoriteCubit, FavoriteState>(
//         builder: (context, state) {
//           if (state is FavoriteLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is FavoriteFailure) {
//             return Center(child: Text('Error: ${state.error}'));
//           }
//           if (state is FavoriteSuccess) {
//             final filter = state.selectedFilter;
//
//             final sections = <Widget>[];
//
//             if ((filter == 'all' || filter == 'restaurants') && state.restaurants.isNotEmpty) {
//               sections.add(const SectionTitle('Restaurants'));
//               sections.addAll(state.restaurants.map((r) =>
//                   RestaurantPageCard(
//                     resturant: r,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => ResturantDetailsPage(resturant: r)),
//                       );
//                     },
//                     onFavoriteTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleRestaurantFavorite(r);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if ((filter == 'all' || filter == 'hotels') && state.hotels.isNotEmpty) {
//               sections.add(const SectionTitle('Hotels'));
//               sections.addAll(state.hotels.map((h) =>
//                   HotelPageCard(
//                     hotel: h,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => RoomsPage(hotel: h)),
//                       );
//                     },
//                     onFavotieTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleHotelFavorite(h);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if ((filter == 'all' || filter == 'trips') && state.trips.isNotEmpty) {
//               sections.add(const SectionTitle('Trips'));
//               sections.addAll(state.trips.map((t) =>
//                   TripPageCard(
//                     trip: t,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => TripDetailsPage(trip: t)),
//                       );
//                     },
//                     onFavoriteTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleTripFavorite(t);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if ((filter == 'all' || filter == 'destinations') && state.destinations.isNotEmpty) {
//               sections.add(const SectionTitle('Destinations'));
//               sections.addAll(state.destinations.map((d) =>
//                   DestinationPageCard(
//                     destination: d,
//                     width: double.infinity,
//                     imageHeight: 200,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => AirLinesPage(destination: d)),
//                       );
//                     },
//                     onFavoriteTap: () async {
//                       final result = await context.read<FavoriteCubit>().toggleDestinationFavorite(d);
//                       SecondSnackBar(result['message'], context, isError: !result['success']);
//                     },
//                   )
//               ));
//             }
//
//             if ((filter == 'all' || filter == 'cars') && state.cars.isNotEmpty) {
//               sections.add(const SectionTitle('Cars'));
//               sections.addAll(state.cars.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final c = entry.value;
//
//                 return CarPageCard(
//                   car: c,
//                   width: double.infinity,
//                   imageHeight: 200,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => CarDetailsPage(
//                           cars: state.cars,
//                           initialIndex: index,
//                           companyName: c.brand,
//                         ),
//                       ),
//                     );
//                   },
//                   onFavoriteTap: () async {
//                     final result = await context.read<FavoriteCubit>().toggleCarFavorite(c);
//                     SecondSnackBar(
//                       result['message'],
//                       context,
//                       isError: !result['success'],
//                     );
//                   },
//                 );
//               }));
//             }
//
//             if (sections.isEmpty) {
//               return const Center(child: Text('No favorites yet.'));
//             }
//
//             return ListView(
//               padding: const EdgeInsets.all(8),
//               children: sections,
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
//
// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle(this.title, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cubits/favoriteCubit/favoriteCubit.dart';
import '../../controller/cubits/favoriteCubit/favoriteState.dart';
import '../widgets/carPageCard.dart';
import '../widgets/destinationPageCard.dart';
import '../widgets/hotelPageCard.dart';
import '../widgets/resturantPageCard.dart';
import '../widgets/secondSnackBar.dart';
import '../widgets/tripPageCard.dart';
import '../widgets/destinationCard.dart';
import 'carDetailsPage.dart';
import 'resturantDetailsPage.dart';
import 'roomsPage.dart';
import 'tripDetailsPage.dart';
import 'airlinePage.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(height: 12),
          _FilterBar(),
          SizedBox(height: 12),
          Expanded(child: _FavoritesContent()),
          SizedBox(height: 70),
        ],
      ),
    );
  }
}

class _FavoritesContent extends StatelessWidget {
  const _FavoritesContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FavoriteFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        if (state is FavoriteSuccess) {
          final filter = state.selectedFilter;
          final sections = <Widget>[];

          if ((filter == 'all' || filter == 'restaurants') && state.restaurants.isNotEmpty) {
            sections.add(const SectionTitle('Restaurants'));
            sections.addAll(state.restaurants.map((r) =>
                RestaurantPageCard(
                  resturant: r,
                  width: double.infinity,
                  imageHeight: 200,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ResturantDetailsPage(resturant: r)));
                  },
                  onFavoriteTap: () async {
                    final result = await context.read<FavoriteCubit>().toggleRestaurantFavorite(r);
                    SecondSnackBar(result['message'], context, isError: !result['success']);
                  },
                )
            ));
          }

          if ((filter == 'all' || filter == 'hotels') && state.hotels.isNotEmpty) {
            sections.add(const SectionTitle('Hotels'));
            sections.addAll(state.hotels.map((h) =>
                HotelPageCard(
                  hotel: h,
                  width: double.infinity,
                  imageHeight: 200,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RoomsPage(hotel: h)));
                  },
                  onFavotieTap: () async {
                    final result = await context.read<FavoriteCubit>().toggleHotelFavorite(h);
                    SecondSnackBar(result['message'], context, isError: !result['success']);
                  },
                )
            ));
          }

          if ((filter == 'all' || filter == 'trips') && state.trips.isNotEmpty) {
            sections.add(const SectionTitle('Trips'));
            sections.addAll(state.trips.map((t) =>
                TripPageCard(
                  trip: t,
                  width: double.infinity,
                  imageHeight: 200,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TripDetailsPage(trip: t)));
                  },
                  onFavoriteTap: () async {
                    final result = await context.read<FavoriteCubit>().toggleTripFavorite(t);
                    SecondSnackBar(result['message'], context, isError: !result['success']);
                  },
                )
            ));
          }

          if ((filter == 'all' || filter == 'destinations') && state.destinations.isNotEmpty) {
            sections.add(const SectionTitle('Destinations'));
            sections.addAll(state.destinations.map((d) =>
                DestinationPageCard(
                  destination: d,
                  width: double.infinity,
                  imageHeight: 200,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AirLinesPage(destination: d)));
                  },
                  onFavoriteTap: () async {
                    final result = await context.read<FavoriteCubit>().toggleDestinationFavorite(d);
                    SecondSnackBar(result['message'], context, isError: !result['success']);
                  },
                )
            ));
          }

          if ((filter == 'all' || filter == 'cars') && state.cars.isNotEmpty) {
            sections.add(const SectionTitle('Cars'));
            sections.addAll(state.cars.asMap().entries.map((entry) {
              final index = entry.key;
              final c = entry.value;

              return CarPageCard(
                car: c,
                width: double.infinity,
                imageHeight: 200,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CarDetailsPage(
                        cars: state.cars,
                        initialIndex: index,
                        companyName: c.brand,
                      ),
                    ),
                  );
                },
                onFavoriteTap: () async {
                  final result = await context.read<FavoriteCubit>().toggleCarFavorite(c);
                  SecondSnackBar(result['message'], context, isError: !result['success']);
                },
              );
            }));
          }

          if (sections.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }

          return ListView(
            padding: const EdgeInsets.all(8),
            children: sections,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar();

  final filters = const [
    'all',
    'cars',
    'hotels',
    'restaurants',
    'trips',
    'destinations'
  ];

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<FavoriteCubit>().state is FavoriteSuccess
        ? (context.watch<FavoriteCubit>().state as FavoriteSuccess).selectedFilter
        : 'all';

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: filters.map((filter) {
          final isSelected = selected == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(
                filter[0].toUpperCase() + filter.substring(1),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              side: BorderSide(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade400,
              ),
              onSelected: (_) {
                context.read<FavoriteCubit>().changeFilter(filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
