import 'package:aaraadhya_temple_dashboard/core/theme/app_colors.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class AppSnackBars {
  static final AppSnackBars _instance = AppSnackBars._internal();

  factory AppSnackBars() {
    return _instance;
  }

  AppSnackBars._internal();

  SnackBar success(Widget? icon, String message) {
    return SnackBar(
      padding: EdgeInsets.all(16.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      margin: EdgeInsets.all(16.0),
      duration: Duration(seconds: 3),
      content: Row(
        children: [
          icon ?? Icon(Icons.check, color: AppColors().white, size: 30.0),
          AppSpacing.horizontalMedium,
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors().white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors().primary,
    );
  }

  SnackBar info(Widget? icon, String message) {
    return SnackBar(
      padding: EdgeInsets.all(16.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      margin: EdgeInsets.all(16.0),
      content: Row(
        children: [
          icon ??
              Icon(Icons.info_outline, color: AppColors().primary, size: 30.0),
          AppSpacing.horizontalMedium,
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors().primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors().grey[50],
    );
  }

  SnackBar error(Widget? icon, String message) {
    return SnackBar(
      padding: EdgeInsets.all(16.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      margin: EdgeInsets.all(16.0),
      content: Row(
        children: [
          icon ??
              Icon(Icons.error_outline, color: AppColors().white, size: 30.0),
          AppSpacing.horizontalMedium,
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors().white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors().error,
    );
  }
}
