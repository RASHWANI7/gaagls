
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/hotelsCubit/hotelsCubit.dart';
import 'package:gaagls/controller/cubits/hotelsCubit/hotelsState.dart';
import 'package:gaagls/view/pages/roomsPage.dart';
import '../widgets/hotelPageCard.dart';
import '../widgets/secondSnackBar.dart';


class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key});

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب المطاعم
    context.read<HotelsCubit>().getHotels();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text('الفنادق')),
      body: SafeArea(
        child: BlocBuilder<HotelsCubit, HotelsState>(
          builder: (context, state) {
            if (state is HotelsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelsSuccess) {
              final hotels = state.hotels;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: HotelPageCard(
                      hotel: hotel,
                      width: double.infinity,
                      imageHeight: screenHeight*0.23,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RoomsPage(hotel: hotel),
                          ),
                        );
                      },
                      onFavotieTap: () async {
                        final result = await context.read<HotelsCubit>().toggleHotelFavorite(hotel);
                        SecondSnackBar(result['message'], context, isError: !result['success']);
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




