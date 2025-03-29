import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ListTile(
            tileColor: context.colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            leading: Icon(Icons.language),
            title: Text(
              context.l10n.appLanguageTileLabel,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              context.l10n.appLanguage,
              style: context.theme.textTheme.bodyMedium,
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
          AppSpacing.verticalSmall,
          ListTile(
            tileColor: context.colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            leading: Icon(Icons.info_outline),
            title: Text(
              context.l10n.aboutTileLabel,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
          AppSpacing.verticalSmall,
          ListTile(
            tileColor: context.colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text(
              context.l10n.privacyPolicyTileLabel,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
          AppSpacing.verticalSmall,
          ListTile(
            tileColor: context.colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            leading: Icon(Icons.gavel_outlined),
            title: Text(
              context.l10n.termsAndConditionsTileLabel,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
          AppSpacing.verticalLarge,
          ListTile(
            tileColor: context.colors.primary[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            leading: Icon(
              Icons.logout_outlined,
              color: context.colorScheme.error,
            ),
            title: Text(
              context.l10n.signOutTileLabel,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_outlined,
              color: context.colorScheme.error,
            ),
          ),
          AppSpacing.verticalLarge,
        ],
      ),
    );
  }
}
