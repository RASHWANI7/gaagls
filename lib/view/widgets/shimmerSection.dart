import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSection extends StatelessWidget {
  final String title;
  final String itemType;

  const ShimmerSection(
      {super.key, required this.title, required this.itemType});

  @override
  Widget build(BuildContext context) {
    double height = 180;
    double width = itemType == "destination" ? 140 : 220;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: height,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Container(
                width: width,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنصر الصورة مع الشيمر
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        height: 120,
                        width: width,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                          color:
                          Colors.white, // لازم لون ثابت عشان shimmer يشتغل
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // اول سطر نصي مع shimmer
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade200,
                            child: Container(
                              height: 12,
                              width: width * 0.6,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // ثاني سطر نصي مع shimmer
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 10,
                              width: width * 0.4,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}