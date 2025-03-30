import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/custom_painters/dotted_border_painter.dart';
import 'package:flutter/material.dart';

class ProfilePictureContainer extends StatelessWidget {
  const ProfilePictureContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colors.grey[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.profilePictureLabel,
            style: context.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacing.verticalMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: FittedBox(
                  child: CircleAvatar(
                    backgroundColor: context.colors.primary[50],
                    child: Icon(
                      Icons.temple_hindu_outlined,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalMedium,
              Expanded(
                child: CustomPaint(
                  painter: DottedBorderPainter(color: context.colors.grey),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: context.colors.primary[50],
                          child: Icon(
                            Icons.upload_outlined,
                            size: 36.0,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        AppSpacing.verticalSmall,
                        Text(
                          context.l10n.uploadNewImageLabel,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSpacing.verticalSmall,
                        Text(
                          context.l10n.imageTypeAndSizeLabel,
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            fontFamily: FontFamily.roboto,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalSmall,
            ],
          ),
        ],
      ),
    );
  }
}
