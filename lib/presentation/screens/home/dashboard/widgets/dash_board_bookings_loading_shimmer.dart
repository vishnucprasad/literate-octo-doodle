import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';

class DashBoardBookingsLoadingShimmer extends StatelessWidget {
  const DashBoardBookingsLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.grey[50],
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: ListTile(
            leading: ShimmerLoader(
              isLoading: true,
              baseColor: context.colors.primary[100],
              highlightColor: context.colors.primary[50],
              child: CircleAvatar(
                backgroundColor: context.colorScheme.primary,
                child: SizedBox.square(dimension: 24.0),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ShimmerLoader(
                isLoading: true,
                showBackground: true,
                baseColor: context.colors.primary[100],
                highlightColor: context.colors.primary[50],
                child: SizedBox(height: 24.0),
              ),
            ),
            subtitle: Row(
              children: [
                ShimmerLoader(
                  isLoading: true,
                  showBackground: true,
                  child: SizedBox(height: 18.0, width: 140.0),
                ),
              ],
            ),
            trailing: ShimmerLoader(
              isLoading: true,
              showBackground: true,
              child: SizedBox(height: 24.0, width: 80.0),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return AppSpacing.verticalSmall;
      },
    );
  }
}
