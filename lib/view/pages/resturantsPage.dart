
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/pages/resturantDetailsPage.dart';
import '../../controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
import '../../controller/cubits/RestaurantsCubit/restaurantsState.dart';
import '../widgets/resturantPageCard.dart';
import '../widgets/secondSnackBar.dart';

class ResturantsPage extends StatefulWidget {
  const ResturantsPage({super.key});

  @override
  State<ResturantsPage> createState() => _ResturantsPageState();
}

class _ResturantsPageState extends State<ResturantsPage> {
  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب المطاعم
    context.read<RestaurantsCubit>().getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resturants'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<RestaurantsCubit, RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RestaurantsSuccess) {
              final restaurants = state.restaurants;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RestaurantPageCard(
                      resturant: restaurant,
                      width: double.infinity,
                      imageHeight: screenHeight * 0.22,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ResturantDetailsPage(resturant: restaurant),
                          ),
                        );
                      },
                      onFavoriteTap: () async {
                        final result = await context.read<RestaurantsCubit>().toggleRestaurantFavorite(restaurant);
                        SecondSnackBar(result['message'], context, isError: !result['success']);
                      },
                    ),
                  );
                },
              );
            } else if (state is RestaurantsFailure) {
              return const Center(child: Text('حدث خطأ أثناء تحميل المطاعم'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}


