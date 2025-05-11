import 'package:flutter/material.dart';

extension MediaQueryUtil on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
