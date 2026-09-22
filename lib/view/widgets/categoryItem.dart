import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../pages/carBrandPage.dart';
import '../pages/destinationsPage.dart';
import '../pages/hotelsPage.dart';
import '../pages/resturantsPage.dart';
import '../pages/tripsPage.dart';


class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color =  Theme.of(context).colorScheme.primary;
    final iconColor =  Theme.of(context).iconTheme.color;
    return Column(
      children: [
        MaterialButton(
          onPressed: onPressed,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(icon, size: 35, color: Colors.white),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "icon": RemixIcons.hotel_line,
        "label": "Hotels",
        "onTap": () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HotelsPage()));
        },
      },
      {
        "icon": RemixIcons.restaurant_line,
        "label": "Resturants",
        "onTap": () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ResturantsPage()));
        },
      },
      {
        "icon": RemixIcons.map_line,
        "label": "Trips",
        "onTap": () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TripsPage()));
        },
      },
      {
        "icon": RemixIcons.car_line,
        "label": "Cars",
        "onTap": () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CarBrandPage()));
        },
      },
      {
        "icon": RemixIcons.plane_line,
        "label": "Destinations",
        "onTap": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DestinationsPage()));
        },
      },
    ];

    return SizedBox(
      height: 120, // لضبط ارتفاع العنصر
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories.map((item) {
            return CategoryItem(
              icon: item['icon'] as IconData,
              label: item['label'] as String,
              onPressed: item['onTap'] as VoidCallback,
            );
          }).toList(),
        ),
      ),
    );
  }
}