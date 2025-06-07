import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';

class BookingsLoadingShimmer extends StatelessWidget {
  const BookingsLoadingShimmer({super.key});

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
            color: context.colors.primary[50],
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: ShimmerLoader(
            isLoading: true,
            baseColor: context.colors.primary[100],
            highlightColor: context.colors.primary[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 20,
                            decoration: BoxDecoration(
                              color: context.colors.primary[100],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          AppSpacing.verticalSmall,
                          Container(
                            width: 160,
                            height: 10,
                            decoration: BoxDecoration(
                              color: context.colors.primary[100],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          AppSpacing.verticalMedium,
                          Container(
                            width: 80,
                            height: 10,
                            decoration: BoxDecoration(
                              color: context.colors.primary[100],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          AppSpacing.verticalMedium,
                          Container(
                            width: 200,
                            height: 10,
                            decoration: BoxDecoration(
                              color: context.colors.primary[100],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: context.colors.primary[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        AppSpacing.verticalMedium,
                        Container(
                          width: 120,
                          height: 20,
                          decoration: BoxDecoration(
                            color: context.colors.primary[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => AppSpacing.verticalMedium,
    );
  }
}
