class Cities {
  final int id;
  final String city;
  final String created_at;
  final String updated_at;

  Cities({
    required this.id,
    required this.city,
    required this.created_at,
    required this.updated_at,
  });


  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: (json['id'] as num).toInt() ,
      city: json['city'] ,
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '', // تعيين قيمة افتراضية في حالة كانت null
    );
  }


  // تحويل البيانات إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'city': city,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  @override
  String toString() {
    return city; // 👈 هذا سيُعرض بدل instance of Cities
  }
}
