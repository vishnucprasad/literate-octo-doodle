import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();

  final white = Color(0xFFFFFFFF);
  final black = Color(0xFF000000);

  static const int _primaryValue = 0xFFFF7E1D;
  static const int _secondaryValue = 0xFF5271FF;
  static const int _greyValue = 0xFFD9D9D9;
  static const int _successValue = 0xFF4CAF50;
  static const int _errorValue = 0xFFE53935;

  final MaterialColor primary = MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFFFF3E0),
    100: Color(0xFFFFE0B2),
    200: Color(0xFFFFCC80),
    300: Color(0xFFFFB74D),
    400: Color(0xFFFFA726),
    500: Color(_primaryValue), // FF7E1D
    600: Color(0xFFF57C00),
    700: Color(0xFFEF6C00),
    800: Color(0xFFE65100),
    900: Color(0xFFD84315),
  });

  final MaterialColor secondary = MaterialColor(_secondaryValue, <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(_secondaryValue), // 5271FF
    600: Color(0xFF3D5AFE),
    700: Color(0xFF304FFE),
    800: Color(0xFF2844FF),
    900: Color(0xFF1A36FF),
  });

  final MaterialColor grey = MaterialColor(_greyValue, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(_greyValue), // D9D9D9
    600: Color(0xFF9E9E9E),
    700: Color(0xFF757575),
    800: Color(0xFF616161),
    900: Color(0xFF424242),
  });

  final MaterialColor success = MaterialColor(_successValue, <int, Color>{
    50: Color(0xFFE8F5E9),
    100: Color(0xFFC8E6C9),
    200: Color(0xFFA5D6A7),
    300: Color(0xFF81C784),
    400: Color(0xFF66BB6A),
    500: Color(_successValue), // 4CAF50
    600: Color(0xFF43A047),
    700: Color(0xFF388E3C),
    800: Color(0xFF2E7D32),
    900: Color(0xFF1B5E20),
  });

  final MaterialColor error = MaterialColor(_errorValue, <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(_errorValue), // E53935
    600: Color(0xFFD32F2F),
    700: Color(0xFFC62828),
    800: Color(0xFFB71C1C),
    900: Color(0xFF891515),
  });
}
