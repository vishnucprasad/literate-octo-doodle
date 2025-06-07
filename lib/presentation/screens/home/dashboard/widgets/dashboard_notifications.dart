import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/dashboard/dashboard_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/notification/notification_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dashboard_notifications_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DashboardNotifications extends ConsumerWidget {
  const DashboardNotifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);
    final notificationController = ref.read(
      notificationControllerProvider.notifier,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.notificationsSectionTitle,
                style: context.theme.textTheme.titleLarge,
              ),
              SizedBox(
                height: 30.0,
                child: FilledButton(
                  onPressed: () {
                    context.push(AppRoutes.notifications.path);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: context.colors.primary[50],
                    foregroundColor: context.colorScheme.primary,
                  ),
                  child: Text(context.l10n.viewAllButtonLabel),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.verticalMedium,
        state.isLoading
            ? DashboardNotificationsLoadingShimmer()
            : state.data.latestNotifications.isEmpty
            ? Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.primary[50],
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Column(
                children: [
                  AppSpacing.verticalSmall,
                  Icon(Icons.block),
                  AppSpacing.verticalSmall,
                  Text(context.l10n.noNotificationsFound),
                  AppSpacing.verticalSmall,
                ],
              ),
            )
            : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.data.latestNotifications.length,
              itemBuilder: (context, index) {
                final notification = state.data.latestNotifications[index];

                return Container(
                  decoration: BoxDecoration(
                    color: context.colors.grey[50],
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: ListTile(
                    onTap: () {
                      context.go(AppRoutes.payments.path);
                      notificationController.deleteNotification(
                        notification.id,
                      );
                    },
                    title: Text(
                      notification.title,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      notification.body,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.grey[700],
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                    trailing: Text(
                      DateFormat('HH:MM a').format(notification.createdAt),
                      style: context.theme.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return AppSpacing.verticalSmall;
              },
            ),
      ],
    );
  }
}
