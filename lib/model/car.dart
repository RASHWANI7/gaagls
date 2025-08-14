
import 'carRentalShop.dart';

class Car {
  final int carId;
  final int carRentalShopId;
  final String brand;
  final String model;
  final String type;
  final String year;
  final String transmission;
  final int seats;
  final String image;
  final int pricePerDay;
  final int rating;
  final String status;
  final String logo;
  final CarRentalShop carRentalShop;
  final bool isFavorite; // ✅ تمت الإضافة

  Car({
    required this.carId,
    required this.carRentalShopId,
    required this.brand,
    required this.model,
    required this.type,
    required this.year,
    required this.transmission,
    required this.seats,
    required this.image,
    required this.pricePerDay,
    required this.rating,
    required this.status,
    required this.logo,
    required this.carRentalShop,
    this.isFavorite = false, // ✅ القيمة الافتراضية
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      carId: (json['car_id'] as num?)?.toInt() ?? 0,
      carRentalShopId: (json['car_rental_shop_id'] as num?)?.toInt() ?? 0,
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      type: json['type'] ?? '',
      year: json['year'] ?? '',
      transmission: json['transmission'] ?? '',
      seats: (json['seats'] as num?)?.toInt() ?? 0,
      image: json['image'] ?? '',
      pricePerDay: (json['price_per_day'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? '',
      logo: json['logo'] ?? '',
      carRentalShop: CarRentalShop.fromJson(json['car_rental_shop'] ?? {}),
      isFavorite: json['is_favorite'] ?? false, // ✅ جلب من API أو القيمة الافتراضية
    );
  }


  // ✅ إضافة copyWith لتحديث isFavorite مثلاً
  Car copyWith({bool? isFavorite}) {
    return Car(
      carId: carId,
      carRentalShopId: carRentalShopId,
      brand: brand,
      model: model,
      type: type,
      year: year,
      transmission: transmission,
      seats: seats,
      image: image,
      pricePerDay: pricePerDay,
      rating: rating,
      status: status,
      logo: logo,
      carRentalShop: carRentalShop,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
