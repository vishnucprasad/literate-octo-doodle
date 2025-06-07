import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/advanced_options/advanced_options_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/advanced_booking_limit_dialog.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingSettings extends ConsumerWidget {
  const BookingSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(advancedOptionsControllerProvider);
    final controller = ref.read(advancedOptionsControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLoader(
          isLoading: state.isLoading,
          showBackground: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.l10n.bookingSettingsLabel,
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
            text: context.l10n.enableOnlineBookingsLabel,
            trailing: Switch(
              inactiveTrackColor: context.colors.grey,
              activeTrackColor: context.colors.primary,
              inactiveThumbColor: context.colors.grey[700],
              value: state.advancedOptions.enableOnlineBooking ?? false,
              onChanged: controller.updateOnlineBookingOption,
            ),
          ),
        ),
        AppSpacing.verticalSmall,
        ShimmerLoader(
          isLoading: state.isLoading,
          child: SettingsTile(
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
                  context.l10n.daysLabelWithDaysCount(
                    state.advancedOptions.advancedOnlneBookingLimit,
                  ),
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.roboto,
                  ),
                ),
                AppSpacing.horizontalSmall,
                Icon(Icons.arrow_forward_ios_outlined, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
