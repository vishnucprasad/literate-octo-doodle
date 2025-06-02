import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/dashboard/dashboard_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardOverviewGrid extends ConsumerWidget {
  const DashboardOverviewGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

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
          value: context.l10n.amountLabel(state.data.totalPayments),
          isLoading: state.isLoading,
        ),
        DashboardCard(
          title: context.l10n.todaysPoojaBookingsCardTitle,
          value: state.data.totalBookings.toString(),
          isLoading: state.isLoading,
        ),
        DashboardCard(
          title: context.l10n.activePoojasCardTitle,
          value: state.data.totalActivePoojas.toString(),
          isLoading: state.isLoading,
        ),
        DashboardCard(
          title: context.l10n.activeEventsCardTitle,
          value: state.data.totalActiveEvents.toString(),
          isLoading: state.isLoading,
        ),
      ],
    );
  }
}
