import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/destinationCubit/destinationCubit.dart';
import 'package:gaagls/view/widgets/secondSnackBar.dart';

import '../../controller/cubits/homeCubit/homeCubit.dart';
import '../../model/destination.dart';

class DestinationPageCard extends StatelessWidget {
  final Destination destination;
  final double width;
  final double imageHeight;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const DestinationPageCard({
    super.key,
    required this.destination,
    required this.width,
    required this.imageHeight,
    required this.onTap,
    required this.onFavoriteTap,
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
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: destination.destinationImage,
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
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Text(
                      destination.destinationCity,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth * 0.037,
                      ),
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
                            destination.isFavorite ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey(destination.isFavorite),
                            color: destination.isFavorite ? Colors.redAccent : Colors.white,
                            size: 26,
                          ),
                        ),
                        onPressed: onFavoriteTap,
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