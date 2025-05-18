import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/payment_details.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentDetailsContainer extends ConsumerWidget {
  const PaymentDetailsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(expandableContainerControllerProvider.notifier);
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      children: [
        AppSpacing.verticalSmall,
        Divider(color: context.colorScheme.primary),
        AppSpacing.verticalSmall,
        PaymentDetails(),
        AppSpacing.verticalMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    foregroundColor: context.colors.white,
                    backgroundColor: context.colors.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: Text(context.l10n.approvePaymentButtonLabel),
                ),
              ),
            ),
            AppSpacing.horizontalSmall,
            Expanded(
              child: SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    foregroundColor: context.colors.white,
                    backgroundColor: context.colors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: Text(
                    context.l10n.rejectPaymentButtonLabel,
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.roboto,
                      color: context.colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.horizontalSmall,
            Expanded(
              child: SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () => controller.setIndex(null),
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    foregroundColor: context.colorScheme.primary,
                    backgroundColor: context.colors.primary[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    side: BorderSide(
                      color: context.colorScheme.primary,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    context.l10n.hideDetailsButtonLabel,
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.roboto,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
