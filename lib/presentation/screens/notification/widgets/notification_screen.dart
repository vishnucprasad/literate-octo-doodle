import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';

class NotificationsLoadingShimmer extends StatelessWidget {
  const NotificationsLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.colors.grey[50],
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: ShimmerLoader(
            isLoading: true,
            child: ListTile(
              tileColor: context.colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: context.colors.primary[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              title: Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: context.colors.primary[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.verticalSmall,
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: context.colors.primary[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  AppSpacing.verticalSmall,
                  Container(
                    width: 140,
                    height: 10,
                    decoration: BoxDecoration(
                      color: context.colors.primary[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
              trailing: Container(
                width: 40,
                height: 10,
                decoration: BoxDecoration(
                  color: context.colors.primary[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => AppSpacing.verticalMedium,
    );
  }
}
