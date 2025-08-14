
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gaagls/model/trip.dart';
import 'package:gaagls/view/pages/reserveTripPage.dart';

class TripDetailsPage extends StatelessWidget {
  final Trip trip;

  const TripDetailsPage({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;
    final isSmallScreen = screenWidth < 600;

    // ألوان جديدة للخلفيات
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
                trip.tripName,
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
                    tag: trip.tripId,
                    child: CachedNetworkImage(
                      imageUrl: trip.tripImage ?? '',
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
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 20,
                vertical: isSmallScreen ? 15 : 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic info card - تم تغيير لون الخلفية هنا
                  _buildCard(
                    backgroundColor: Theme.of(context).cardColor, // استخدام اللون الجديد
                    child: Column(
                      children: [
                        // Timeline row - تم تغيير لون الخلفية هنا
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor, // لون أفتح
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [ // إضافة ظل خفيف
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    trip.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Start Date",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).iconTheme.color
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.airplanemode_active, color: Theme.of(context).colorScheme.secondary, size: 30),
                              Column(
                                children: [
                                  Text(
                                    trip.end,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.secondary
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "End Date",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).iconTheme.color
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoCard(
                              icon: Icons.attach_money,
                              title: 'Price',
                              value: '${trip.tripPrice}',
                              color: Colors.green,
                              isSmallScreen: isSmallScreen,
                              backgroundColor: Theme.of(context).secondaryHeaderColor,
                              context: context
                            ),
                            _buildInfoCard(
                              icon: Icons.business,
                              title: 'Tourist Office',
                              value: trip.tourist_office_name,
                              color: Theme.of(context).colorScheme.secondary,
                              isSmallScreen: isSmallScreen,
                              backgroundColor: Theme.of(context).secondaryHeaderColor,
                              context: context
                            ),
                          ],
                        ),
                      ],
                    ),
                    context: context
                  ),
                  const SizedBox(height: 20),
                  // Description card - تم تغيير لون الخلفية هنا
                  _buildCard(
                    backgroundColor: Theme.of(context).cardColor, // استخدام اللون الجديد
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trip Description",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          trip.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ],
                    ),
                    context: context
                  ),
                  const SizedBox(height: 20),
                  // Destination info card - تم تغيير لون الخلفية هنا
                  _buildCard(
                    backgroundColor: Theme.of(context).cardColor, // استخدام اللون الجديد
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Destination Information",
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
                                Icons.location_city,
                                "City",
                                trip.tourist_office_city,
                                Theme.of(context).colorScheme.secondary,
                                backgroundColor: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildDestinationInfo(
                                Icons.flag,
                                "Country",
                                trip.tourist_office_country,
                                Colors.green.shade700,
                                backgroundColor: Theme.of(context).secondaryHeaderColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    context: context
                  ),

                  const SizedBox(height: 20),

                _buildCard(
                  backgroundColor:  Theme.of(context).cardColor, // أزرق فاتح
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hotel Details",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: _buildHotelFeature(
                              Icons.hotel,
                              "Hotel Name",
                              trip.trip_hotel_name,
                              Theme.of(context).secondaryHeaderColor,
                              context
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildHotelFeature(
                              Icons.location_on,
                              "Location",
                              trip.trip_hotel_location,
                              Theme.of(context).secondaryHeaderColor,
                              context
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ✅ التقييم داخل child مباشرة
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).secondaryHeaderColor.withOpacity(0.3),
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
                              "Hotel Rating",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            RatingBarIndicator(
                              rating: double.tryParse(trip.trip_hotel_stars.toString()) ?? 0,
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
                  context: context
                ),




                const SizedBox(height: 20),
                  if (trip.tripActivities.isNotEmpty)
                    _buildCard(
                      backgroundColor: Theme.of(context).cardColor, // استخدام اللون الجديد
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Activities",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 15),
                          _buildActivitiesList(trip.tripActivities,context),
                        ],
                      ),
                      context: context
                    ),
                  SizedBox(height: isSmallScreen ? 80 : 100),
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
              color: Theme.of(context).primaryColor.withOpacity(0.5),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TripReservePage(trip: trip),
                ),
              );
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
  Widget _buildCard({
    required Widget child,
    required Color backgroundColor,
    required BuildContext context
  }) {
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

  Widget _buildActivitiesList(List<TripActivity> activities,BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const Divider(height: 20),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Container( // إضافة ظل لكل نشاط
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).secondaryHeaderColor,
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor, // لون أفتح
                borderRadius: BorderRadius.circular(12),
                boxShadow: [ // إضافة ظل خفيف
                  BoxShadow(
                    color: Colors.blue.shade300,
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.event, color: Colors.blue),
            ),
            title: Text(
              activity.activityName,
              style:  TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).iconTheme.color
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 5),
                    Text(
                      activity.date,
                      style: TextStyle(fontSize: 14, color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Theme.of(context).iconTheme.color),
                    const SizedBox(width: 5),
                    Text(
                      '${activity.start} - ${activity.end}',
                      style: TextStyle(fontSize: 14, color: Theme.of(context).iconTheme.color),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // تعديل دالة بطاقة المعلومات لقبول لون خلفية مخصص
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required bool isSmallScreen,
    required BuildContext context,
    required Color backgroundColor  // لون خلفية جديد
  }) {
    return Container(
      width: isSmallScreen ? 140 : 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor, // استخدام اللون المخصص
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
        boxShadow: [ // إضافة ظل خفيف
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallScreen ? 15 : 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }

  // تعديل دالة معلومات الوجهة لقبول لون خلفية مخصص
  Widget _buildDestinationInfo(
      IconData icon,
      String title,
      String value,
      Color color, {
        Color backgroundColor = const Color(0xFFF0F8FF), // لون خلفية جديد
      }) {
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
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelFeature(IconData icon, String title, String value, Color color,BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.shade100, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}