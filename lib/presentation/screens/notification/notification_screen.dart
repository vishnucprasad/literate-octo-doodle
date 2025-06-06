import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/notification/notification_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/notification/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationControllerProvider);
    final controller = ref.read(notificationControllerProvider.notifier);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: HomeAppBar(
          title: context.l10n.notificationsSectionTitle,
          actions: [
            SizedBox(
              height: 30,
              child: FilledButton(
                onPressed: controller.clearAllNotifications,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  backgroundColor: context.colors.grey[100],
                  foregroundColor: context.colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child:
                    state.isClearing
                        ? SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(),
                        )
                        : Text(context.l10n.clearAllButtonLabel),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            state.isLoading
                ? NotificationsLoadingShimmer()
                : state.notifications.isEmpty
                ? SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notification_important_outlined,
                        size: 72,
                        color: context.colors.grey[700],
                      ),
                      AppSpacing.verticalMedium,
                      Text(
                        context.l10n.noNotificationsFound,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.colors.grey[900],
                          fontFamily: FontFamily.roboto,
                          fontVariations: [FontVariation('wght', 400)],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                : ListView.separated(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        context.go(AppRoutes.payments.path);
                        controller.deleteNotification(
                          state.notifications[index].id,
                        );
                      },
                      tileColor: context.colors.grey[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      leading: Icon(
                        Icons.notifications_active_outlined,
                        color: context.colorScheme.primary,
                      ),
                      title: Text(
                        state.notifications[index].title,
                        style: context.theme.textTheme.titleSmall?.copyWith(
                          // color: context.colorScheme.primary,
                        ),
                      ),
                      subtitle: Text(
                        state.notifications[index].body,
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        DateFormat(
                          "HH:mm a",
                        ).format(state.notifications[index].createdAt),
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.roboto,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => AppSpacing.verticalMedium,
                ),
      ),
    );
  }
}
