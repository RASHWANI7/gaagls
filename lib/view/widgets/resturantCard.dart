import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/homeCubit/homeCubit.dart';
import 'package:gaagls/view/widgets/secondSnackBar.dart';

import '../../controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
import '../../model/resturant.dart';

class RestaurantCard extends StatelessWidget {
  final Resturant resturant;
  final double width;
  final double imageHeight;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const RestaurantCard({
    super.key,
    required this.resturant,
    required this.width,
    required this.imageHeight,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                    tag: resturant.resturantId.toString(),
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: resturant.resturantImage,
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
                          resturant.resturantName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.037,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              resturant.city,
                              style: TextStyle(
                                fontSize: screenWidth * 0.029,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(
                            resturant.stars,
                                (index) => const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${resturant.openTime} - ${resturant.closeTime}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.028,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

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
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Icon(
                            resturant.isFavorite ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey(resturant.isFavorite),
                            color: resturant.isFavorite ? Colors.redAccent : Colors.white,
                            size: 26,
                          ),
                        ),
                        onPressed: () async {
                          final result = await context.read<HomeCubit>().toggleRestaurantFavorite(resturant);
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