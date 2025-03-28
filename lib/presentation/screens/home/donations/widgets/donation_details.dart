import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.donationDetailsSectionTitle,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.donationPurposeLabel),
        AppSpacing.verticalSmall,
        Text(
          "Temple Renovation Fund",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.donationDateAndTimeLabel),
        AppSpacing.verticalSmall,
        Text(
          DateFormat("MMMM d, y • h:mm a").format(DateTime.now()),
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Row(
          children: [
            Text(context.l10n.statusLabel),
            AppSpacing.horizontalSmall,
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: context.colors.success,
                borderRadius: BorderRadius.circular(14.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(
                context.l10n.completedBadgeLabel,
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: context.colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.roboto,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.paymentMethodLabel),
        AppSpacing.verticalSmall,
        Text(
          "UPI ( johndoe@pingpay )",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.transactionIdLabel),
        AppSpacing.verticalSmall,
        Text(
          "1234567890",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
