import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.isLoading,
  });

  final String title;
  final String value;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primary[50],
      shadowColor: context.colorScheme.outline,
      elevation: 0.05,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ShimmerLoader(
                isLoading: isLoading,
                baseColor: context.colors.primary[100],
                highlightColor: context.colors.primary[50],
                showBackground: true,
                child: Text(
                  value,
                  style: context.theme.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.roboto,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
