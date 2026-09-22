// import 'package:flutter/material.dart';
//
// class DestinationsPage extends StatelessWidget {
//   const DestinationsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text('destinations Page')),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsCubit.dart';
// import 'package:gaagls/controller/cubits/RestaurantsCubit/restaurantsState.dart';
//
// class HotelsPage extends StatelessWidget {
//   const HotelsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Text('hotels page')
//     );
//   }
// }
//




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/hotelsCubit/hotelsCubit.dart';
import 'package:gaagls/controller/cubits/hotelsCubit/hotelsState.dart';
import 'package:gaagls/view/pages/roomsPage.dart';
import 'package:gaagls/view/widgets/destinationCard.dart';
import '../../controller/cubits/destinationCubit/destinationCubit.dart';
import '../../controller/cubits/destinationCubit/destinationState.dart';
import '../widgets/destinationPageCard.dart';
import '../widgets/hotelPageCard.dart';
import '../widgets/secondSnackBar.dart';
import 'airlinePage.dart';


class DestinationsPage extends StatefulWidget {
  const DestinationsPage({super.key});

  @override
  State<DestinationsPage> createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {

  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب المطاعم
    context.read<DestinationsCubit>().getDestinations();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Destinations'),centerTitle: true,),
      body: SafeArea(
        child: BlocBuilder<DestinationsCubit, DestinationsState>(
          builder: (context, state) {
            if (state is DestinationsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DestinationsSuccess) {
              final destinations = state.destinations;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DestinationPageCard(
                      destination: destination,
                      width: double.infinity,
                      imageHeight: screenHeight*0.2,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AirLinesPage(destination: destination,),
                          ),
                        );
                      },
                      onFavoriteTap: () async {
                        final result = await context.read<DestinationsCubit>().toggleDestinationFavorite(destination);
                        SecondSnackBar(
                          result['message'],
                          context,
                          isError: !result['success'],
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is HotelsFailure) {
              return const Center(child: Text('حدث خطأ أثناء تحميل الفنادق'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}




