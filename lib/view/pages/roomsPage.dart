import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/controller/cubits/roomCubit/roomCubit.dart';
import 'package:gaagls/controller/cubits/roomCubit/roomState.dart';
import 'package:gaagls/view/pages/roomDetailsPage.dart';
import '../../model/hotel.dart';
import '../../model/room.dart';
import '../widgets/roomCard.dart';


class RoomsPage extends StatefulWidget {
  final Hotel hotel;
  const RoomsPage({super.key,required this.hotel});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  @override
  void initState() {
    super.initState();
    // استدعاء دالة جلب المطاعم
    context.read<RoomsCubit>().getRooms(hotelId: widget.hotel.hotelId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rooms'),centerTitle: true,),
      body: SafeArea(
        child: BlocBuilder<RoomsCubit, RoomsState>(
          builder: (context, state) {
            if (state is RoomsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoomsSuccess) {
              final rooms = state.rooms;

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RoomCard(
                      room: room,
                      width: double.infinity,
                      imageHeight: 200,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RoomDetailsPage(room: room),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is RoomsFailure) {
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

