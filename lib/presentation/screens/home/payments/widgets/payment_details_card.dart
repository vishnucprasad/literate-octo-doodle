import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/payment_details_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class PaymentDetailsCard extends ConsumerWidget {
  const PaymentDetailsCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIndex = ref.watch(expandableContainerControllerProvider);
    final controller = ref.read(expandableContainerControllerProvider.notifier);

    final payment = ref.watch(paymentsControllerProvider).payments[index];

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colors.primary[50],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            payment.devotee.displayName,
                            style: context.theme.textTheme.titleMedium
                                ?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AppSpacing.verticalSmall,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${context.l10n.paymentIdLabel}: ',
                                  style: context.theme.textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontVariations: [
                                          FontVariation('wght', 700),
                                          FontVariation('wdth', 100),
                                        ],
                                      ),
                                ),
                                TextSpan(
                                  text: payment.id,
                                  style: context.theme.textTheme.bodySmall
                                      ?.copyWith(fontFamily: FontFamily.roboto),
                                ),
                              ],
                            ),
                          ),
                          AppSpacing.verticalMedium,
                          Text(
                            DateFormat(
                              "MMMM d, y • h:mm a",
                            ).format(payment.createdAt),
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              fontFamily: FontFamily.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.colors.success[50],
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(color: context.colors.success),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      context.l10n.paymentBadgeLabel(payment.price),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.success,
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ),
                  AppSpacing.verticalSmall,
                  if (expandedIndex != index)
                    SizedBox(
                      height: 26,
                      child: FilledButton(
                        onPressed: () => controller.setIndex(index),
                        style: FilledButton.styleFrom(
                          textStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.roboto,
                              ),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                        child: Text(context.l10n.viewDetailsButtonLabel),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (expandedIndex == index) PaymentDetailsContainer(),
        ],
      ),
    );
  }
}
