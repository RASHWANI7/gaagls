// class TripStop {
//   final int id;
//   final int tripId;
//   final String name;
//   final String date;
//   final String start;
//   final String end;
//
//   TripStop({
//     required this.id,
//     required this.tripId,
//     required this.name,
//     required this.date,
//     required this.start,
//     required this.end,
//   });
//
//   factory TripStop.fromJson(Map<String, dynamic> json) {
//     return TripStop(
//       id: json['id'] as int,
//       tripId: json['trip_id'] as int,
//       name: json['trip_stop_name'] ?? '',
//       date: json['date'] ?? '',
//       start: json['start'] ?? '',
//       end: json['end'] ?? '',
//     );
//   }
//
//   // مهم للعرض داخل الـ Dropdown
//   @override
//   String toString() => name;
// }


class TripStop {
  final int id;
  final int tripId;
  final String tripStopName;
  final DateTime? date;
  final String start; // ممكن تحوله لـ TimeOfDay لو تحب
  final String end;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TripStop({
    required this.id,
    required this.tripId,
    required this.tripStopName,
    required this.date,
    required this.start,
    required this.end,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripStop.fromJson(Map<String, dynamic> json) {
    return TripStop(
      id: (json['id'] as num).toInt(),
      tripId: (json['trip_id'] as num).toInt(),
      tripStopName: json['trip_stop_name'] ?? '',
      //date: DateTime.parse(json['date']),
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      start: json['start'] ?? '',
      end: json['end'] ?? '',
      // createdAt: DateTime.parse(json['created_at']) ,
      // updatedAt: DateTime.parse(json['updated_at']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_id': tripId,
      'trip_stop_name': tripStopName,
      'date': date?.toIso8601String(),
      'start': start,
      'end': end,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() => tripStopName;
}

