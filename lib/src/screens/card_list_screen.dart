import 'dart:developer';
import 'dart:math' as math;

import 'package:car_3d_card_list/src/models/car_model.dart';
import 'package:car_3d_card_list/src/utils/media_query_util.dart';
import 'package:car_3d_card_list/src/utils/responsive_util.dart';
import 'package:car_3d_card_list/src/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// 자동차 카드를 그리드 형태로 보여주는 화면
class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  /// breankpoint에 따라 그리드의 프로퍼티를 설정하여 delegate를 반환한다.
  SliverGridDelegate get _gridDelegate {
    final (
      int axisCount,
      double crossSpacing,
      double mainSpacing,
    ) = switch (context.currentBreakpointName) {
      MOBILE => (1, 0, 40),
      TABLET => (2, 10, 20),
      _ => (2, 4, 8),
    };

    return SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 3 / 2,
      crossAxisCount: axisCount,
      crossAxisSpacing: crossSpacing.w,
      mainAxisSpacing: mainSpacing.w,
    );
  }

  /// breankpoint에 따라 그리드 패딩을 반환한다.
  EdgeInsets get _gridPadding {
    return switch (context.currentBreakpointName) {
      MOBILE ||
      TABLET => EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
      _ => EdgeInsets.symmetric(
        horizontal: math.max(30.w, (context.screenWidth - 1200) / 2),
        vertical: 30.w,
      ),
    };
  }

  void _routeToDetailScreen(CarModel car) {
    // TODO
    // Navigator.push(
    //   context,
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 1),
    //     reverseTransitionDuration: const Duration(seconds: 1),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return FadeTransition(opacity: animation, child: child);
    //     },
    //     pageBuilder: (context, animation, secondaryAnimation) {
    //       return CarDetailScreen(car: car);
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3D Car Cards')),
      body: GridView.builder(
        padding: _gridPadding,
        gridDelegate: _gridDelegate,
        cacheExtent: 1,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];

          return CarCard(
            car: car,
            onTap: () {
              _routeToDetailScreen(car);
            },
          );
        },
      ),
    );
  }
}
