import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/custom_painters/dotted_border_painter.dart';
import 'package:flutter/material.dart';

class PoojaImagePicker extends StatelessWidget {
  const PoojaImagePicker({super.key});

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
            context.l10n.poojaImageLabel,
            style: context.theme.textTheme.bodyMedium,
          ),
          AppSpacing.verticalMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.grey[100],
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalMedium,
              Expanded(
                flex: 3,
                child: FittedBox(
                  child: GestureDetector(
                    onTap: () {},
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
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            AppSpacing.verticalSmall,
                            Text(
                              context.l10n.imageTypeAndSizeLabel,
                              style: context.theme.textTheme.bodySmall
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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
