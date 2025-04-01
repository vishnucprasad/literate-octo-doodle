import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/contact_details/widgets/contact_details_action_buttons.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/contact_details/widgets/contact_text_field_group.dart';
import 'package:flutter/material.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            AppSpacing.verticalMedium,
            Text(
              context.l10n.templeCommiteeMembersLabel,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalMedium,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return ContactTextFieldGroup(index: index);
              },
              separatorBuilder: (context, index) => AppSpacing.verticalSmall,
            ),
            SizedBox(
              height: 40,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: context.colors.grey[50],
                  foregroundColor: context.colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Text(context.l10n.addMemberButtonTitle),
              ),
            ),
            AppSpacing.verticalMedium,
            Text(
              context.l10n.chiefPriestLabel,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalMedium,
            Row(
              children: [
                Expanded(child: AppInputField(hint: context.l10n.nameLabel)),
                AppSpacing.horizontalSmall,
                Expanded(child: AppInputField(hint: context.l10n.numberLabel)),
              ],
            ),
            AppSpacing.verticalMedium,
            Text(
              context.l10n.moreDetailsLabel,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSpacing.verticalMedium,
            AppInputField(
              hint: context.l10n.addressHintText,
              labelText: context.l10n.addressLabel,
            ),
            AppSpacing.verticalMedium,
            AppInputField(
              hint: context.l10n.locationLinkHintText,
              labelText: context.l10n.locationLinkLabel,
            ),
            AppSpacing.verticalMedium,
            AppInputField(
              hint: context.l10n.websiteLinkHintText,
              labelText: context.l10n.websiteLinkLabel,
            ),
            AppSpacing.verticalFromPixels(100),
          ],
        ),
        ContactDetailsActionButtons(),
      ],
    );
  }
}
