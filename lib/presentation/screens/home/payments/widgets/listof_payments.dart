import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/payment_details_card.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/payments_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ListofPayments extends ConsumerWidget {
  const ListofPayments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            context.l10n.paymentsSectionTitle(
              DateFormat('MMMM').format(state.selectedDate),
              DateFormat('d').format(state.selectedDate),
            ),
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: context.colors.grey[900],
              fontFamily: FontFamily.roboto,
              fontVariations: [FontVariation('wght', 400)],
            ),
          ),
        ),
        AppSpacing.verticalMedium,
        state.isLoading
            ? PaymentsLoadingShimmer()
            : state.payments.isEmpty
            ? SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block_outlined,
                    size: 72,
                    color: context.colors.grey[700],
                  ),
                  AppSpacing.verticalMedium,
                  Text(
                    context.l10n.noPaymentsFound,
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      color: context.colors.grey[900],
                      fontFamily: FontFamily.roboto,
                      fontVariations: [FontVariation('wght', 400)],
                    ),
                  ),
                ],
              ),
            )
            : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.payments.length,
              itemBuilder: (context, index) {
                return PaymentDetailsCard(index: index);
              },
              separatorBuilder: (context, index) => AppSpacing.verticalMedium,
            ),
      ],
    );
  }
}
