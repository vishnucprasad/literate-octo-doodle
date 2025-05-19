import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentDetails extends ConsumerWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIndex = ref.watch(expandableContainerControllerProvider);

    if (expandedIndex == null) return Placeholder();

    final payment =
        ref.watch(paymentsControllerProvider).payments[expandedIndex];

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
              payment.paymentDetails.paymentMethod,
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
                color: switch (payment.status) {
                  BookingStatus.pending => context.colorScheme.primary,
                  BookingStatus.confirmed ||
                  BookingStatus.completed ||
                  BookingStatus.refunded => context.colors.success,
                  BookingStatus.rejected ||
                  BookingStatus.canceled => context.colorScheme.error,
                },
                borderRadius: BorderRadius.circular(14.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(
                payment.status.getName(context),
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
        Image.network(payment.paymentDetails.screenshotUrl),
      ],
    );
  }
}
