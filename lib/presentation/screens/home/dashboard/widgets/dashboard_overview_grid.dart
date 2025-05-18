import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardOverviewGrid extends StatelessWidget {
  const DashboardOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 1.75,
      ),
      children: [
        DashboardCard(
          title: context.l10n.todaysPaymentsCardTitle,
          value: context.l10n.amountLabel("24,500"),
        ),
        DashboardCard(
          title: context.l10n.todaysPoojaBookingsCardTitle,
          value: '12',
        ),
        DashboardCard(title: context.l10n.activePoojasCardTitle, value: '23'),
        DashboardCard(title: context.l10n.activeEventsCardTitle, value: '4'),
      ],
    );
  }
}
