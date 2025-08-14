
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/airlineCubit/airlineCubit.dart';
import 'package:gaagls/controller/cubits/airlineCubit/airlineState.dart';
import 'package:gaagls/controller/cubits/tripCubit/tripState.dart';
import 'package:gaagls/model/destination.dart';
import 'package:gaagls/view/pages/airlineDetailsPage.dart';
import '../widgets/airlineCard.dart';

class AirLinesPage extends StatefulWidget {
  final Destination destination;
  const AirLinesPage({super.key,required this.destination});

  @override
  State<AirLinesPage> createState() => _AirLinesPageState();
}

class _AirLinesPageState extends State<AirLinesPage> {
  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب المطاعم
    context.read<AirLinesCubit>().getAirLines(destinationId: widget.destination.destinationId);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('AirLines'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AirLinesCubit, AirLinesState>(
          builder: (context, state) {
            if (state is AirLinesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AirLinesSuccess) {
              final airlines = state.airlines;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: airlines.length,
                itemBuilder: (context, index) {
                  final airline = airlines[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AirlineCard(
                      airline: airline,
                      width: double.infinity,
                      imageHeight: screenHeight * 0.24,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AirlineDetailsPage(airline: airline,destinationId: widget.destination.destinationId,)));
                      },
                    ),
                  );
                },
              );
            } else if (state is TripsFailure) {
              return const Center(child: Text('حدث خطأ أثناء تحميل الرحلات'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}



