import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static final AppTextTheme _instance = AppTextTheme._internal();

  factory AppTextTheme() {
    return _instance;
  }

  AppTextTheme._internal();

  static final _colors = AppColors();

  static final TextTheme textTheme = ThemeData.light().textTheme.copyWith(
    // Large Display Texts (For Hero Texts)
    displayLarge: _baseStyle(57, FontWeight.w700),
    displayMedium: _baseStyle(45, FontWeight.w600),
    displaySmall: _baseStyle(36, FontWeight.w500),

    // Headline Texts
    headlineLarge: _baseStyle(32, FontWeight.w600),
    headlineMedium: _baseStyle(28, FontWeight.w500),
    headlineSmall: _baseStyle(24, FontWeight.w500),

    // Title Texts
    titleLarge: _baseStyle(22, FontWeight.w500),
    titleMedium: _baseStyle(18, FontWeight.w500),
    titleSmall: _baseStyle(16, FontWeight.w500),

    // Body Texts
    bodyLarge: _baseStyle(16, FontWeight.w400, color: _colors.black), // Body1
    bodyMedium: _baseStyle(14, FontWeight.w400, color: _colors.black), // Body2
    bodySmall: _baseStyle(
      12,
      FontWeight.w400,
      color: _colors.grey[700]!,
    ), // Caption
    // Labels (For Buttons & Small Texts)
    labelLarge: _baseStyle(14, FontWeight.w600, color: _colors.primary),
    labelMedium: _baseStyle(12, FontWeight.w500, color: _colors.primary),
    labelSmall: _baseStyle(11, FontWeight.w400, color: _colors.grey[700]!),
  );

  static TextStyle _baseStyle(double size, FontWeight weight, {Color? color}) {
    return TextStyle(
      fontFamily: FontFamily.raleway,
      fontSize: size,
      fontWeight: weight,
      color: color ?? _colors.black,
      height: 1.3, // Default line height
      letterSpacing: 0.5, // Slight spacing
      fontVariations: [
        FontVariation('wght', weight.value.toDouble()), // Adjust weight
        FontVariation('wdth', 100), // Keep width standard
      ],
    );
  }
}
