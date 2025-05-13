import 'dart:io';

import 'package:car_3d_card_list/generated/assets.dart';

class CarModel {
  final List<File> images;
  final File logo;
  final String brand;
  final String model;

  String get name => '$brand $model';

  //<editor-fold desc="Data Methods">
  const CarModel({
    required this.images,
    required this.logo,
    required this.brand,
    required this.model,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarModel &&
          runtimeType == other.runtimeType &&
          images == other.images &&
          logo == other.logo &&
          brand == other.brand &&
          model == other.model);

  @override
  int get hashCode =>
      images.hashCode ^ logo.hashCode ^ brand.hashCode ^ model.hashCode;

  @override
  String toString() {
    return 'CardModel{' +
        ' images: $images,' +
        ' logo: $logo,' +
        ' brand: $brand,' +
        ' model: $model,' +
        '}';
  }

  CarModel copyWith({
    List<File>? images,
    File? logo,
    String? brand,
    String? model,
  }) {
    return CarModel(
      images: images ?? this.images,
      logo: logo ?? this.logo,
      brand: brand ?? this.brand,
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return {'images': images, 'logo': logo, 'brand': brand, 'model': model};
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      images: map['images'] as List<File>,
      logo: map['logo'] as File,
      brand: map['brand'] as String,
      model: map['model'] as String,
    );
  }

  //</editor-fold>
}

final cars = <CarModel>[
  CarModel(
    images: [
      File(Assets.imagesLamborghiniUrusSE1),
      File(Assets.imagesLamborghiniUrusSE2),
      File(Assets.imagesLamborghiniUrusSE3),
    ],
    logo: File(Assets.logoLamborghini),
    brand: 'Lamborghini',
    model: 'Urus SE',
  ),
  CarModel(
    images: [
      File(Assets.imagesPorscheCayenneCoupe1),
      File(Assets.imagesPorscheCayenneCoupe2),
      File(Assets.imagesPorscheCayenneCoupe3),
    ],
    logo: File(Assets.logoPorsche),
    brand: 'Porsche',
    model: 'Cayenne Coupe',
  ),
  CarModel(
    images: [
      File(Assets.imagesBMWX5MCompetition1),
      File(Assets.imagesBMWX5MCompetition2),
      File(Assets.imagesBMWX5MCompetition3),
    ],
    logo: File(Assets.logoBMW),
    brand: 'BMW',
    model: 'X5 M Competition',
  ),
  CarModel(
    images: [
      File(Assets.imagesMercedesGClass1),
      File(Assets.imagesMercedesGClass2),
      File(Assets.imagesMercedesGClass3),
    ],
    logo: File(Assets.logoBenz),
    brand: 'Mercedes-Benz',
    model: 'G-Class',
  ),

  CarModel(
    images: [
      File(Assets.imagesAudiRS71),
      File(Assets.imagesAudiRS72),
      File(Assets.imagesAudiRS73),
    ],
    logo: File(Assets.logoAudi),
    brand: 'Audi',
    model: 'RS7',
  ),
];
