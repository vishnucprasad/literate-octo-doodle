import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/common/filters/filters_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentFilters extends ConsumerWidget {
  const PaymentFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(filtersControllerProvider);
    final controller = ref.read(filtersControllerProvider.notifier);
    final paymentController = ref.read(paymentsControllerProvider.notifier);
    final payments = ref.watch(
      paymentsControllerProvider.select((state) => state.payments),
    );

    final List<String> filters = [
      context.l10n.allPaymentsLabelWithCount(payments.length),
      context.l10n.pendingBadgeLabel,
      context.l10n.approvedBadgeLabel,
      context.l10n.rejectedBadgeLabel,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilledButton(
              onPressed: () {
                controller.selectIndex(index);
                switch (index) {
                  case 0:
                    paymentController.changeFilter(null);
                    break;
                  case 1:
                    paymentController.changeFilter(BookingStatus.pending);
                    break;
                  case 2:
                    paymentController.changeFilter(BookingStatus.confirmed);
                    break;
                  case 3:
                    paymentController.changeFilter(BookingStatus.rejected);
                  default:
                    paymentController.changeFilter(null);
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor:
                    isSelected
                        ? context.colors.primary[50]
                        : context.colors.grey[100],
                foregroundColor:
                    isSelected
                        ? context.colors.primary
                        : context.colors.grey[900],
                textStyle:
                    isSelected
                        ? context.theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.roboto,
                        )
                        : context.theme.textTheme.bodyLarge?.copyWith(
                          fontFamily: FontFamily.roboto,
                        ),
              ),
              child: Text(filters[index]),
            ),
          );
        }),
      ),
    );
  }
}
