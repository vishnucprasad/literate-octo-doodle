import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_bookings_preview.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_notifications.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_overview_grid.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_quick_actions.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.dashboardAppBarTitle),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                DashboardOverviewGrid(),
                AppSpacing.verticalMedium,
                DashboardQuickActions(),
                AppSpacing.verticalMedium,
                DashboardBookingsPreview(),
                AppSpacing.verticalMedium,
                DashboardNotifications(),
                AppSpacing.verticalMedium,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
