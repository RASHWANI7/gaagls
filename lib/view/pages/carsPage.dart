import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/cubits/carScreenCubit/carScreenCubit.dart';
import '../../controller/cubits/carScreenCubit/carScreenState.dart';
import '../widgets/carPageCard.dart';
import '../widgets/secondSnackBar.dart';
import 'carDetailsPage.dart';

class CarsPage extends StatefulWidget {
  final String brandName; // العلامة التجارية القادمة من الصفحة السابقة

  const CarsPage({
    Key? key,
    required this.brandName,
  }) : super(key: key);

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CarsCubit>().getCars(widget.brandName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" ${widget.brandName}"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),

      body: BlocBuilder<CarsCubit, CarsState>(
        builder: (context, state) {
          if (state is CarsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarsSuccess) {
            final cars = state.brandCars[widget.brandName] ?? [];

            if (cars.isEmpty) {
              return const Center(child: Text("No cars found for this brand."));
            }


            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                return CarPageCard(
                  car: car,
                  width: double.infinity,
                  imageHeight: 200,
                  onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CarDetailsPage(
                              cars: cars,
                              initialIndex: index,
                              companyName: widget.brandName,
                            ),
                          ),
                        );
                  },
                  onFavoriteTap: () async {
                    final result =
                    await context.read<CarsCubit>().toggleCarFavorite(car);
                    SecondSnackBar(
                      result['message'],
                      context,
                      isError: !result['success'],
                    );
                  },
                );
              },
            );

          } else if (state is CarsFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
