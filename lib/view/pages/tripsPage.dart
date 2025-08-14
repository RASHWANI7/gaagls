import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/tripCubit/tripCubit.dart';
import 'package:gaagls/controller/cubits/tripCubit/tripState.dart';
import 'package:gaagls/view/pages/tripDetailsPage.dart';
import '../../model/trip.dart';
import '../widgets/secondSnackBar.dart';
import '../widgets/tripPageCard.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب المطاعم
    context.read<TripsCubit>().getTrips();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {
            if (state is TripsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripsSuccess) {
              final trips = state.trips;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  final trip = trips[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TripPageCard(
                      trip: trip,
                      width: double.infinity,
                      imageHeight: screenHeight * 0.24,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TripDetailsPage(trip: trip),
                          ),
                        );
                      },
                      onFavoriteTap: () async {
                        final result = await context.read<TripsCubit>().toggleTripFavorite(trip);
                        SecondSnackBar(result['message'], context, isError: !result['success']);
                      },
                    ),
                  );
                },
              );
            } else if (state is TripsFailure) {
              return const Center(child: Text('حدث خطأ أثناء تحميل الرحلات'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}




// class TripCard extends StatelessWidget {
//   final Trip trip;
//   final VoidCallback? onTap;
//
//   const TripCard({
//     super.key,
//     required this.trip,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         height: 300,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(28),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 24,
//               offset: const Offset(0, 12),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(28),
//           child: Stack(
//             children: [
//               // الخلفية: صورة الرحلة
//               CachedNetworkImage(
//                 imageUrl: trip.tripImage,
//                 width: double.infinity,
//                 height: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//
//               // التدرج الزجاجي السفلي
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 height: 140,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.7)
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),
//               ),
//
//               // التفاصيل النصية
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       trip.tripName,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         shadows: [Shadow(color: Colors.black, blurRadius: 4)],
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on,
//                             color: Colors.white70, size: 20),
//                     const SizedBox(width: 4),
//                         Text(
//                           trip.destination,
//                           style: const TextStyle(
//                               color: Colors.white70, fontSize: 18),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.hotel,
//                             color: Colors.white70, size: 20),
//                         const SizedBox(width: 4),
//                         Text(
//                           trip.trip_hotel_name,
//                           style: const TextStyle(
//                               color: Colors.white70, fontSize: 18),
//                         ),
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ),
//
//               // السعر (أعلى اليمين)
//               Positioned(
//                 top: 20,
//                 right: 20,
//                 child: Container(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(20),
//                     //backdropFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                   ),
//                   child: Text(
//                     "\$ ${trip.tripPrice}",
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
