class CarBrand {
  final String brandName;
  final String brandImage;

  CarBrand
      ({
    required this.brandName,
    required this.brandImage,

  });

  factory CarBrand.fromJson(Map<String, dynamic> json) {
    return CarBrand(
      brandName: json['brand'] ??'',
      brandImage: json['logo'] ??'',

    );
  }

  // تحويل البيانات إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'brand' : brandName,
      'logo': brandImage,

    };
  }

}



