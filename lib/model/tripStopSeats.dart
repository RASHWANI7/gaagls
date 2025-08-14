// class TripStopSeat {
//   final int id;
//   final int tripStopId;
//   final String seatType;
//   final int seatCount;
//   final int price;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   TripStopSeat({
//     required this.id,
//     required this.tripStopId,
//     required this.seatType,
//     required this.seatCount,
//     required this.price,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory TripStopSeat.fromJson(Map<String, dynamic> json) {
//     return TripStopSeat(
//       id: (json['id'] as num).toInt(),
//       tripStopId: (json['trip_stop_id'] as num).toInt() ,
//       seatType: json['seat_type'] ?? '',
//       seatCount: int.tryParse(json['seat_count'].toString()) ?? 0,
//       price: (json['price'] as num).toInt(),
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'trip_stop_id': tripStopId,
//       'seat_type': seatType,
//       'seat_count': seatCount.toString(),
//       'price': price,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }


class TripStopSeat {
  final int? id;
  final int? tripStopId;
  final String seatType;
  final int seatCount;
  final int price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TripStopSeat({
    required this.id,
    required this.tripStopId,
    required this.seatType,
    required this.seatCount,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripStopSeat.fromJson(Map<String, dynamic> json) {
    return TripStopSeat(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      tripStopId: json['trip_stop_id'] != null ? int.tryParse(json['trip_stop_id'].toString()) : null,
      seatType: json['seat_type']?.toString() ?? '',
      seatCount: int.tryParse(json['seat_count'].toString()) ?? 0,
      price: int.tryParse(json['price'].toString()) ?? 0,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_stop_id': tripStopId,
      'seat_type': seatType,
      'seat_count': seatCount,
      'price': price,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() => seatType;
}
