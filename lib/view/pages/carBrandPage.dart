// import 'package:flutter/material.dart';
//
// class CarBrandPage extends StatefulWidget {
//   const CarBrandPage({super.key});
//
//   @override
//   State<CarBrandPage> createState() => _CarBrandPageState();
// }
//
// class _CarBrandPageState extends State<CarBrandPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/pages/carsPage.dart';

import '../../controller/cubits/carBrandCubit/carBrandCubit.dart';
import '../../controller/cubits/carBrandCubit/carBrandState.dart';


class CarBrandPage extends StatefulWidget {
  const CarBrandPage({super.key});

  @override
  State<CarBrandPage> createState() => _CarBrandPageState();
}

class _CarBrandPageState extends State<CarBrandPage> {
  @override
  void initState() {
    super.initState();
    context.read<CarBrandsCubit>().getCarBrands(); // ✅ استدعاء التابع
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Brands"),
        centerTitle: true,
      ),
      body: BlocBuilder<CarBrandsCubit, CarBrandsState>(
        builder: (context, state) {
          if (state is CarBrandsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CarBrandsFailure) {
            return Center(child: Text(state.error));
          }

          else if (state is CarBrandsSuccess) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: state.carbrands.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final brand = state.carbrands[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CarsPage(brandName: brand.brandName),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: screenWidth * 0.4,
                          height: screenHeight * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: brand.brandImage,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          brand.brandName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }



          // else if (state is CarBrandsSuccess) {
          //   return Padding(
          //     padding: const EdgeInsets.all(12),
          //     child: GridView.builder(
          //       itemCount: state.carbrands.length,
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 16,
          //         crossAxisSpacing: 16,
          //         childAspectRatio: 0.9,
          //       ),
          //       itemBuilder: (context, index) {
          //         final brand = state.carbrands[index];
          //         return GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (_) => CarsPage(brandName: brand.brandName),
          //               ),
          //             );
          //           },
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Container(
          //                 width: screenWidth*0.4,
          //                 height: screenHeight*0.2,
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.grey.withOpacity(0.2),
          //                       blurRadius: 6,
          //                       offset: const Offset(0, 4),
          //                     ),
          //                   ],
          //                 ),
          //                 child: ClipOval(
          //                   child: Image.network(
          //                     brand.brandImage,
          //                     fit: BoxFit.cover,
          //                     errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 40),
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(height: 10),
          //               Text(
          //                 brand.brandName,
          //                 textAlign: TextAlign.center,
          //                 style: const TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   );
          // }


          else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
