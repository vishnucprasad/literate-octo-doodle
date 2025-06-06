import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/notification/notification_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_bookings_preview.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_notifications.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_overview_grid.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      notificationControllerProvider.select(
        (state) => state.isTappedOnNotification,
      ),
      (_, isTappedOnNotification) {
        if (isTappedOnNotification) context.go(AppRoutes.payments.path);
      },
    );

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
