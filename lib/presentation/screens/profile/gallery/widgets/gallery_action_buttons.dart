import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GalleryActionButtons extends StatelessWidget {
  const GalleryActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(top: BorderSide(color: context.colors.grey, width: 0.5)),
      ),
      child: Column(
        children: [
          AppSpacing.verticalMedium,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colors.error,
                    side: BorderSide(color: context.colors.error, width: 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  icon: Icon(Icons.delete_outline),
                  label: Text(context.l10n.deleteButtonLabel),
                ),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  icon: Icon(Icons.upload_outlined),
                  label: Text(context.l10n.uploadButtonLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
