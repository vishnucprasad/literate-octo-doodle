import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const SizedBox verticalSmall = SizedBox(height: 8.0);
  static const SizedBox verticalMedium = SizedBox(height: 16.0);
  static const SizedBox verticalLarge = SizedBox(height: 32.0);

  static const SizedBox horizontalSmall = SizedBox(width: 8.0);
  static const SizedBox horizontalMedium = SizedBox(width: 16.0);
  static const SizedBox horizontalLarge = SizedBox(width: 32.0);

  static SizedBox verticalFromPixels(double pixels) => SizedBox(height: pixels);
  static SizedBox horizontalFromPixels(double pixels) =>
      SizedBox(width: pixels);
}
