import 'package:car_3d_card_list/src/screens/card_list_screen.dart';
import 'package:car_3d_card_list/src/utils/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Car3DCardApp extends StatelessWidget {
  const Car3DCardApp({super.key});

  ThemeData get _darkTheme {
    final themeData = ThemeData.dark();

    return themeData.copyWith(
      scaffoldBackgroundColor: Color(0xFF0E0E0E),
      cardTheme: CardThemeData(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3D Car Card',
      home: CarListScreen(),
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: _darkTheme,
      builder: (context, child) {
        ScreenUtil.init(context);

        return MediaQuery.withNoTextScaling(
          child: _buildResponsiveLayout(child),
        );
      },
    );
  }

  Widget _buildResponsiveLayout(Widget? child) {
    final resolvedChild = Builder(
      builder:
          (context) =>
              context.currentBreakpointName != null ? child! : SizedBox(),
    );

    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 900, name: TABLET),
        const Breakpoint(start: 901, end: double.infinity, name: DESKTOP),
      ],
      child: resolvedChild,
    );
  }
}
