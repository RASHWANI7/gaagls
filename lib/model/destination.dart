// class Destination {
//   final int destinationId;
//   final String destinationCity;
//   final String destinationImage;
//
//   Destination
//       ({
//     required this.destinationId,
//     required this.destinationCity,
//     required this.destinationImage,
//
//   });
//
//
//   factory Destination.fromJson(Map<String, dynamic> json) {
//     return Destination(
//       destinationId: (json['id'] as num).toInt(),
//       destinationCity: json['city'] ?? '',
//       destinationImage: json['image'] ?? '',
//     );
//   }
//
//   // تحويل البيانات إلى JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id' : destinationId,
//       'tourist_office_id': destinationCity,
//       'tourist_office_name': destinationImage,
//     };
//   }
//
//
// }
//
//
//




class Destination {
  final int destinationId;
  final String destinationCity;
  final String destinationImage;
  final bool isFavorite; // ✅ إضافة

  Destination({
    required this.destinationId,
    required this.destinationCity,
    required this.destinationImage,
    this.isFavorite = false, // القيمة الافتراضية
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      destinationId: (json['id'] as num).toInt(),
      destinationCity: json['city'] ?? '',
      destinationImage: json['image'] ?? '',
      isFavorite: json['is_favorite'] ?? false, // جلب من الـ API
    );
  }

  // copyWith لتحديث isFavorite أو غيره
  Destination copyWith({
    int? destinationId,
    String? destinationCity,
    String? destinationImage,
    bool? isFavorite,
  }) {
    return Destination(
      destinationId: destinationId ?? this.destinationId,
      destinationCity: destinationCity ?? this.destinationCity,
      destinationImage: destinationImage ?? this.destinationImage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

// لا نعدل toJson كما طلبت
}
