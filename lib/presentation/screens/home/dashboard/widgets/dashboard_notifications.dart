import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class DashboardNotifications extends StatelessWidget {
  const DashboardNotifications({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
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
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: context.colors.grey[50],
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: ListTile(
                title: Text(
                  context.l10n.newPoojaBookingNotificationTitle,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  context.l10n.newPoojaBookingNotificationDescription(
                    'John Doe',
                    index + 1,
                  ),
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.colors.grey[700],
                    fontFamily: FontFamily.roboto,
                  ),
                ),
                trailing: Text(
                  '${10 + index}:00 AM',
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
