import 'package:aaraadhya_temple_dashboard/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  AppColors get colors => AppColors();
}
