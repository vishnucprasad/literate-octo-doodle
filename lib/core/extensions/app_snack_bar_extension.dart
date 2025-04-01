import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_snack_bars.dart';
import 'package:flutter/material.dart';

extension AppSnackbarExtension on BuildContext {
  AppSnackBars get appSnackbars => AppSnackBars();

  void showSuccessSnackbar({Widget? icon, required String message}) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(appSnackbars.success(icon, message));
  }

  void showInfoSnackbar({Widget? icon, required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(appSnackbars.info(icon, message));
  }

  void showErrorSnackbar({Widget? icon, required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(appSnackbars.error(icon, message));
  }
}
