import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ResponsiveUtil on BuildContext {
  /// Returns the current breakpoint name.
  String get currentBreakpointName {
    return ResponsiveBreakpoints.of(this).breakpoint.name ?? DESKTOP;
  }
}
