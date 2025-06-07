import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/date_selector.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/listof_payments.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/payment_filters.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentsScreen extends ConsumerWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(paymentsControllerProvider, (previous, next) {
      final error = next.error;

      if (previous?.error != next.error) {
        if (error is DatabaseException) {
          context.showErrorSnackbar(
            message: error.getDatabaseExceptionMessage(context),
          );
        }
      }
    });

    final state = ref.watch(paymentsControllerProvider);
    final controller = ref.read(paymentsControllerProvider.notifier);

    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.paymentsManagementAppBarTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                DateSelector(
                  dateList: state.dateList,
                  selectedDateIndex: state.selectedDateIndex,
                  selectDate: controller.selectDate,
                  invert: true,
                ),
                AppSpacing.verticalMedium,
                PaymentFilters(),
                AppSpacing.verticalMedium,
                ListofPayments(),
                AppSpacing.verticalMedium,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
