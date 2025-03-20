import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/core/theme/app_colors.dart';
import 'package:aaraadhya_temple_dashboard/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();
  static final AppColors _colors = AppColors();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    typography: Typography.material2021(),
    colorScheme: ColorScheme.light().copyWith(
      primary: _colors.primary,
      secondary: _colors.secondary,
      surface: _colors.white,
      tertiary: _colors.error[300],
      error: _colors.error,
      outline: _colors.grey[200],
      onPrimary: _colors.white,
      onSecondary: _colors.white,
      onSurface: _colors.black,
      onError: _colors.white,
      onTertiary: _colors.white,
    ),
    textTheme: AppTextTheme.textTheme,
    fontFamily: FontFamily.raleway,
  );
}
