import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/advanced_booking_limit_dialog.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/settings_tile.dart';
import 'package:flutter/material.dart';

class BookingSettings extends StatelessWidget {
  const BookingSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            context.l10n.bookingSettingsLabel,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
        ),
        AppSpacing.verticalMedium,
        SettingsTile(
          text: context.l10n.enableOnlineBookingsLabel,
          trailing: Switch(value: true, onChanged: (value) {}),
        ),
        AppSpacing.verticalSmall,
        SettingsTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AdvancedBookingLimitDialog();
              },
            );
          },
          text: context.l10n.advancedBookingLimitLabel,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.daysLabelWithDaysCount(30),
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                ),
              ),
              AppSpacing.horizontalSmall,
              Icon(Icons.arrow_forward_ios_outlined, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}
