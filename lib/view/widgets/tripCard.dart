import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/widgets/secondSnackBar.dart';

import '../../controller/cubits/homeCubit/homeCubit.dart';
import '../../model/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final double width;
  final double imageHeight;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const TripCard({
    super.key,
    required this.trip,
    required this.width,
    required this.imageHeight,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:  Theme.of(context).cardColor,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: trip.tripId,
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: trip.tripImage ?? '',
                        width: width,
                        height: imageHeight,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: width,
                          height: imageHeight,
                          color: Colors.grey[300],
                          child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: width,
                          height: imageHeight,
                          color: Colors.grey,
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.tripName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.037,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (trip.tripPrice != null)
                          Text(
                            '${trip.tripPrice!.toStringAsFixed(2)} \$',
                            style: TextStyle(
                              fontSize: screenWidth * 0.034,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700],
                            ),
                          ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              trip.destination ?? '',
                              style: TextStyle(
                                fontSize: screenWidth * 0.029,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Positioned(
              //   top: 8,
              //   right: 8,
              //   child: IconButton(
              //     icon: Icon(
              //       trip.isFavorite ? Icons.favorite : Icons.favorite_border,
              //       color: trip.isFavorite ? Colors.red : Colors.grey,
              //     ),
              //     onPressed: () {
              //       context.read<HomeCubit>().toggleTripFavorite(context,trip);
              //     },
              //   ),
              // ),

              Positioned(
                top: 7,
                right: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Icon(
                            trip.isFavorite ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey(trip.isFavorite),
                            color: trip.isFavorite ? Colors.redAccent : Colors.white,
                            size: 26,
                          ),
                        ),
                        onPressed: () async {
                          final result = await context.read<HomeCubit>().toggleTripFavorite(trip);
                          SecondSnackBar(
                            result['message'],
                            context,
                            isError: !result['success'],
                          );
                        },
                        splashRadius: 28,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}