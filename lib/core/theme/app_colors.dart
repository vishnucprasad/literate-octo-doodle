import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();

  final white = Color(0xFFFFFFFF);
  final black = Color(0xFF000000);

  static const int _primaryValue = 0xFF8B0000;
  static const int _secondaryValue = 0xFFFFD700;
  static const int _greyValue = 0xFFD9D9D9;
  static const int _successValue = 0xFF34C759;
  static const int _errorValue = 0xFFFF0E0E;

  final MaterialColor primary = MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFFFE5E5),
    100: Color(0xFFFFB8B8),
    200: Color(0xFFFF8A8A),
    300: Color(0xFFFF5C5C),
    400: Color(0xFFFF2E2E),
    500: Color(_primaryValue), // 8B0000
    600: Color(0xFF7E0000),
    700: Color(0xFF660000),
    800: Color(0xFF4D0000),
    900: Color(0xFF330000),
  });

  final MaterialColor secondary = MaterialColor(_secondaryValue, <int, Color>{
    50: Color(0xFFFFFAE0),
    100: Color(0xFFFFF2B3),
    200: Color(0xFFFFEA80),
    300: Color(0xFFFFE14D),
    400: Color(0xFFFFD920),
    500: Color(_secondaryValue), // FFD700
    600: Color(0xFFE6C200),
    700: Color(0xFFCCAD00),
    800: Color(0xFFB39900),
    900: Color(0xFF998500),
  });

  final MaterialColor grey = MaterialColor(_greyValue, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF2F2F2),
    200: Color(0xFFE6E6E6),
    300: Color(0xFFD9D9D9),
    400: Color(0xFFBFBFBF),
    500: Color(_greyValue), // D9D9D9
    600: Color(0xFFA6A6A6),
    700: Color(0xFF8C8C8C),
    800: Color(0xFF737373),
    900: Color(0xFF595959),
  });

  final MaterialColor success = MaterialColor(_successValue, <int, Color>{
    50: Color(0xFFE5FAEB),
    100: Color(0xFFB8F0CB),
    200: Color(0xFF8AE5AB),
    300: Color(0xFF5CDA8B),
    400: Color(0xFF34C759),
    500: Color(_successValue), // 34C759
    600: Color(0xFF2EAF50),
    700: Color(0xFF268D41),
    800: Color(0xFF1E6B32),
    900: Color(0xFF164923),
  });

  final MaterialColor error = MaterialColor(_errorValue, <int, Color>{
    50: Color(0xFFFFE5E5),
    100: Color(0xFFFFB8B8),
    200: Color(0xFFFF8A8A),
    300: Color(0xFFFF5C5C),
    400: Color(0xFFFF2E2E),
    500: Color(_errorValue), // FF0E0E
    600: Color(0xFFE60D0D),
    700: Color(0xFFCC0B0B),
    800: Color(0xFFB30909),
    900: Color(0xFF990707),
  });
}
