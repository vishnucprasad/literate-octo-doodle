import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/advanced_options/advanced_options_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationSetttings extends ConsumerWidget {
  const NotificationSetttings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(advancedOptionsControllerProvider);
    final controller = ref.watch(advancedOptionsControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLoader(
          isLoading: state.isLoading,
          showBackground: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.l10n.notificationsAndAlertsLabel,
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ),
        AppSpacing.verticalMedium,
        ShimmerLoader(
          isLoading: state.isLoading,
          child: SettingsTile(
            text: context.l10n.smsNotificationsForDevoteesLabel,
            trailing: Switch(
              inactiveTrackColor: context.colors.grey,
              activeTrackColor: context.colors.primary,
              inactiveThumbColor: context.colors.grey[700],
              value: state.advancedOptions.smsNotificationForDevotees ?? false,
              onChanged: controller.updateSmsNotification,
            ),
          ),
        ),
        AppSpacing.verticalSmall,
        ShimmerLoader(
          isLoading: state.isLoading,
          child: SettingsTile(
            text: context.l10n.emailNotificationsForDevoteesLabel,
            trailing: Switch(
              inactiveTrackColor: context.colors.grey,
              activeTrackColor: context.colors.primary,
              inactiveThumbColor: context.colors.grey[700],
              value:
                  state.advancedOptions.emailNotificationForDevotees ?? false,
              onChanged: controller.updateEmailNotification,
            ),
          ),
        ),
      ],
    );
  }
}
