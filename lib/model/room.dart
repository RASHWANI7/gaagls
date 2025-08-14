class Room {
  final int roomId;
  final int hotelId;
  final String type;
  final int capacity;
  final int price;
  final int rating;
  final String description;
  final String roomImage;
  final String roomStatus;
  final String created_at;
  final String updated_at;


  Room
      ({
    required this.roomId,
    required this.hotelId,
    required this.type,
    required this.capacity,
    required this.price,
    required this.rating,
    required this.description,
    required this.roomImage,
    required this.roomStatus,
    required this.created_at,
    required this.updated_at,
  });



  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: (json['id']as num).toInt(),
      hotelId: (json['hotel_id'] as num).toInt() ,
      type:  json['type'] ?? '',
      capacity: (json['capacity'] as num).toInt() ,
      price: (json['price'] as num).toInt() ,
      rating: (json['rating'] as num).toInt() ,
      description: json['description'] ?? '',
      roomImage: json['image'] ?? '',
      roomStatus: json['status'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
    );
  }


  // تحويل البيانات إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id' : roomId,
      'hotel_id' : hotelId,
      'type' : type,
      'capacity' : capacity,
      'price' : price,
      'rating' : rating,
      'description' : description,
      'image' : roomImage,
      'status' : roomStatus,
      'created_at' : created_at,
      'updated_at' : updated_at,
    };
  }


}



