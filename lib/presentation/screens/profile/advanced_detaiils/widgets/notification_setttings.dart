import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class NotificationSetttings extends StatelessWidget {
  const NotificationSetttings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.notificationsAndAlertsLabel,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ),
        AppSpacing.verticalMedium,
        SettingsTile(
          text: context.l10n.smsNotificationsForDevoteesLabel,
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
        AppSpacing.verticalSmall,
        SettingsTile(
          text: context.l10n.emailNotificationsForDevoteesLabel,
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
      ],
    );
  }
}
