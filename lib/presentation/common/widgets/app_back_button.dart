import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 44,
      child: IconButton(
        onPressed: () => context.canPop() ? context.pop() : null,
        icon: Icon(Icons.arrow_back_ios_new),
        style: IconButton.styleFrom(
          backgroundColor: backgroundColor ?? context.colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          iconSize: 16.0,
        ),
      ),
    );
  }
}
