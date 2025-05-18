import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/date_selector.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/listof_payments.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/payments/widgets/payment_filters.dart';
import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.paymentsManagementAppBarTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                DateSelector(),
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
