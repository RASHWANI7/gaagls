import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/carBrand.dart';

class CarBrandCard extends StatelessWidget {
  final CarBrand brand;
  final VoidCallback? onTap;

  const CarBrandCard({
    super.key,
    required this.brand,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,15,0),
        child: Column(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: brand.brandImage,
                width: 75,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 60),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              brand.brandName,
              style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}