import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/advanced_options/advanced_options_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/bank_details_form.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/change_password_form.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSettings extends ConsumerWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(advancedOptionsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLoader(
          isLoading: state.isLoading,
          showBackground: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.l10n.accountSettingsLabel,
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
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return BankDetailsForm();
                },
              );
            },
            text: context.l10n.bankDetailsForPoojaPaymentsLabel,
            trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
          ),
        ),
        AppSpacing.verticalSmall,
        ShimmerLoader(
          isLoading: state.isLoading,
          child: SettingsTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return ChangePasswordForm();
                },
              );
            },
            text: context.l10n.changePasswordLabel,
            trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16),
          ),
        ),
      ],
    );
  }
}
