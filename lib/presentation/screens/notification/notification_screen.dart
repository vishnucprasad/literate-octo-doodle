import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: HomeAppBar(
          title: context.l10n.notificationsSectionTitle,
          actions: [
            SizedBox(
              height: 30,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  backgroundColor: context.colors.grey[100],
                  foregroundColor: context.colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Text(context.l10n.clearAllButtonLabel),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: context.colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              leading: Icon(
                Icons.notifications_active_outlined,
                color: context.colorScheme.primary,
              ),
              title: Text(
                "Notification Title",
                style: context.theme.textTheme.titleSmall?.copyWith(
                  // color: context.colorScheme.primary,
                ),
              ),
              subtitle: Text(
                "Notification Subtitle lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                DateFormat("HH:mm a").format(
                  DateTime.now().subtract(
                    Duration(hours: index, minutes: index),
                  ),
                ),
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                  color: context.colorScheme.primary,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => AppSpacing.verticalMedium,
          itemCount: 5,
        ),
      ),
    );
  }
}
