import 'dart:io';

import 'package:car_3d_card_list/generated/assets.dart';

class CarModel {
  final List<File> images;
  final File logo;
  final int year;
  final String brand;
  final String model;
  final int speed; // km/h 단위의 최고 속력


  String get name => '$brand $model';

  //<editor-fold desc="Data Methods">
  const CarModel({
    required this.images,
    required this.logo,
    required this.year,
    required this.brand,
    required this.model,
    required this.speed,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarModel &&
          runtimeType == other.runtimeType &&
          images == other.images &&
          logo == other.logo &&
          year == other.year &&
          brand == other.brand &&
          model == other.model &&
          speed == other.speed);

  @override
  int get hashCode =>
      images.hashCode ^
      logo.hashCode ^
      year.hashCode ^
      brand.hashCode ^
      model.hashCode ^
      speed.hashCode;

  @override
  String toString() {
    return 'CardModel{' +
        ' images: $images,' +
        ' logo: $logo,' +
        ' year: $year,' +
        ' brand: $brand,' +
        ' model: $model,' +
        ' speed: $speed,' +
        '}';
  }

  CarModel copyWith({
    List<File>? images,
    File? logo,
    int? year,
    String? brand,
    String? model,
    int? speed,
  }) {
    return CarModel(
      images: images ?? this.images,
      logo: logo ?? this.logo,
      year: year ?? this.year,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      speed: speed ?? this.speed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'images': this.images,
      'logo': this.logo,
      'year': this.year,
      'brand': this.brand,
      'model': this.model,
      'speed': this.speed,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      images: map['images'] as List<File>,
      logo: map['logo'] as File,
      year: map['year'] as int,
      brand: map['brand'] as String,
      model: map['model'] as String,
      speed: map['speed'] as int,
    );
  }

  //</editor-fold>
}

final cars = <CarModel>[
  CarModel(
    images: [
      File(Assets.imagesLamborghiniUrusSE20241),
      File(Assets.imagesLamborghiniUrusSE20242),
      File(Assets.imagesLamborghiniUrusSE20243),
    ],
    logo: File(Assets.logoLamborghini),
    year: 2024,
    brand: 'Lamborghini',
    model: 'Urus SE',
    speed: 290,
  ),
  // CardModel(
  //   images: [
  //     File('assets/images/porsche_cayenne_coupe_2024.png'),
  //     File('assets/images/porsche_cayenne_coupe_2024_2.png'),
  //   ],
  //   logo: File('assets/logo/porsche.png'),
  //   year: 2024,
  //   brand: 'Porsche',
  //   model: 'Cayenne Coupe',
  // ),
  // CardModel(
  //   images: [
  //     File('assets/images/bmw_x6_m_2024.png'),
  //     File('assets/images/bmw_x6_m_2024_2.png'),
  //   ],
  //   logo: File('assets/logo/bmw.png'),
  //   year: 2024,
  //   brand: 'BMW',
  //   model: 'X6 M',
  // ),
  // CardModel(
  //   images: [
  //     File('assets/images/mercedes_benz_gle_coupe_2024.png'),
  //     File('assets/images/mercedes_benz_gle_coupe_2024_2.png'),
  //   ],
  //   logo: File('assets/logo/mercedes_benz.png'),
  //   year: 2024,
  //   brand: 'Mercedes-Benz',
  //   model: 'GLE Coupe',
  // ),
];
