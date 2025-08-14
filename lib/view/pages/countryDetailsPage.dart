import 'package:flutter/material.dart';
import 'package:gaagls/model/destination.dart';

class CountryDetailsPage extends StatelessWidget {
  final Destination destination;

  const CountryDetailsPage({Key? key, required this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.destinationCity),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الوجهة
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Image.network(
                destination.destinationImage,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // اسم المدينة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                destination.destinationCity,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // الوصف (إذا كان موجودًا)
            // if (destination.description != null && destination.description!.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: Text(
            //       destination.description!,
            //       style: const TextStyle(fontSize: 16),
            //     ),
            //   ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
