import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.paymentDetailsSectionTitle,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Row(
          children: [
            Text(context.l10n.paymentMethodLabel),
            Text(
              " : ",
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontFamily: FontFamily.roboto,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "UPI",
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontFamily: FontFamily.roboto,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        AppSpacing.verticalMedium,
        Row(
          children: [
            Text(context.l10n.statusLabel),
            Text(
              " : ",
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontFamily: FontFamily.roboto,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(14.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(
                context.l10n.pendingBadgeLabel,
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
        Text(context.l10n.paymentScreenshotLabel),
        AppSpacing.verticalSmall,
        Image.network(
          'https://firebasestorage.googleapis.com/v0/b/project-aaraadhya-v1.firebasestorage.app/o/booking%2FXoytlnwEfZY45nTcq3xfU5nXSdy2%2FibuXlg4QhCe9rIb2dUe6V1CEmG53%2FPixel_1747542316751_6ch9stan.jpg?alt=media&token=267b5e5a-635f-458c-a006-468603220543',
        ),
      ],
    );
  }
}
