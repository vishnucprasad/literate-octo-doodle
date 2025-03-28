import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class TaxDetails extends StatelessWidget {
  const TaxDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.taxExemptionReceiptSectionTitle,
          style: context.theme.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.receiptNumberLabel),
        AppSpacing.verticalSmall,
        Text(
          "RE-2025-03-28-001",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(
          context.l10n.taxExemptionReceiptSectionDescription,
          style: context.theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Row(
          children: [
            SizedBox(
              height: 36,
              child: FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: context.colors.success,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                icon: Icon(Icons.mobile_screen_share_outlined),
                label: Text(context.l10n.shareTaxReceiptButtonLabel),
              ),
            ),
            AppSpacing.horizontalMedium,
            SizedBox(
              height: 36,
              child: FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: context.colors.primary[50],
                  foregroundColor: context.colorScheme.primary,
                  side: BorderSide(
                    width: 1,
                    color: context.colorScheme.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                icon: Icon(Icons.print_outlined),
                label: Text(context.l10n.printButtonLabel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
