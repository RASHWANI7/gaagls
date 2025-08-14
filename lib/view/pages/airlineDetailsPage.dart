import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaagls/model/airline.dart';
import 'package:gaagls/model/trip.dart';
import 'package:gaagls/view/pages/reserveAirlinePage.dart';
import 'package:gaagls/view/pages/reserveTripPage.dart';
import 'package:google_fonts/google_fonts.dart';

class AirlineDetailsPage extends StatelessWidget {
  final Airline airline;
  final int destinationId;

  const AirlineDetailsPage({super.key, required this.airline,required this.destinationId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;
    final isSmallScreen = screenWidth < 600;

    // ألوان جديدة للخلفيات
    const cardBackground = Color(0xFFF9FBFF); // لون فاتح مائل للأزرق
    const timelineBackground = Color(0xFFE8F4FD); // لون أفتح للجدول الزمني
    const infoCardBackground = Color(0xFFF0F8FF); // لون خلفية بطاقات المعلومات

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.35,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                airline.airlineName,
                style: TextStyle(
                  fontSize: isSmallScreen ? 16 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 15, // زيادة الظل هنا
                      offset: Offset(1, 2), // زيادة الإزاحة
                    )
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: airline.airlineId,
                    child: CachedNetworkImage(
                      imageUrl: airline.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                          ),
                        ),
                        child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                          ),
                        ),
                        child: const Icon(Icons.image, color: Colors.white70, size: 50),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15,5,15,screenHeight*0.15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 20),

// 🟦 بطاقة التقييم
                  _buildCard(
                    backgroundColor: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Airline Rating",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade100.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            border: Border.all(color: Colors.blue.shade100, width: 1.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Restaurant Rating",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              RatingBarIndicator(
                                rating: double.tryParse(airline.stars.toString()) ?? 0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow[600],
                                ),
                                itemCount: 5,
                                itemSize: 28.0,
                                unratedColor: Colors.blue.shade100,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    context: context,
                  ),

                  const SizedBox(height: 15),

// 🟦 بطاقة الموقع
                  _buildCard(
                    backgroundColor: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Airline Location",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDestinationInfo(
                                icon: Icons.location_city,
                                title: "City",
                                value: ' ${airline.location}',
                                color: Theme.of(context).colorScheme.secondary,
                                backgroundColor: Theme.of(context).secondaryHeaderColor,
                                context: context,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    context: context,
                  ),

                  const SizedBox(height: 20),

// 🟦 الوصف
                  _buildCard(
                    backgroundColor: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Airline Description",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          airline.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ],
                    ),
                    context: context,
                  ),




                ],
              ),
            ),
          ),



        ],
      ),
      floatingActionButton: Container(
        height: isSmallScreen ? 55 : 65,
        width: screenWidth * (isSmallScreen ? 0.95 : 0.9),
        margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [ // زيادة الظل هنا
            BoxShadow(
              color: Colors.blue.shade700.withOpacity(0.5),
              blurRadius: 20, // زيادة من 15 إلى 20
              spreadRadius: 3, // زيادة من 2 إلى 3
              offset: const Offset(0, 6), // زيادة من 5 إلى 6
            ),
          ],
          gradient: const LinearGradient(
            colors: [Color(0xFF0D47A1), Color(0xFF1E88E5)], // تعديل طفيف في التدرج
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReserveAirlinePage(airline: airline,destinationId: destinationId,)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.confirmation_number, color: Colors.white, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Book Now',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 18 : 20,
                    shadows: const [ // إضافة ظل للنص
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // تعديل دالة البطاقة لقبول لون خلفية مخصص
  Widget _buildCard({required Widget child, required Color backgroundColor,required BuildContext context }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // استخدام اللون المخصص
        borderRadius: BorderRadius.circular(20),
        boxShadow: [ // زيادة الظل هنا
          BoxShadow(
            color: Colors.blue.shade500.withOpacity(0.5), // زيادة الشفافية
            blurRadius: 20, // زيادة من 15 إلى 20
            spreadRadius: 3, // زيادة من 2 إلى 3
            offset: const Offset(0, 6), // زيادة من 5 إلى 6
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  // تعديل دالة معلومات الوجهة لقبول لون خلفية مخصص
  Widget _buildDestinationInfo({
   required IconData icon,
   required String title,
   required String value,
   required Color color,
   required Color backgroundColor,
    required BuildContext context
  }
      ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor, // استخدام اللون المخصص
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.1), width: 1.5),
        boxShadow: [ // إضافة ظل خفيف
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.w700
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }


}