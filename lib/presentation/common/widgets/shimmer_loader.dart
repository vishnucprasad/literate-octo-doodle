import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    super.key,
    required this.isLoading,
    this.showBackground = false,
    this.baseColor,
    this.highlightColor,
    required this.child,
  });

  final bool isLoading;
  final bool showBackground;
  final Color? baseColor;
  final Color? highlightColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: baseColor ?? context.colors.grey[200]!,
      highlightColor: highlightColor ?? context.colors.grey[50]!,
      child: Container(
        decoration: BoxDecoration(
          color: showBackground ? context.colorScheme.surface : null,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: child,
      ),
    );
  }
}
