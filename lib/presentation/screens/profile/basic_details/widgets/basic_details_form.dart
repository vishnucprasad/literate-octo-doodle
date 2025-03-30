import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/time_range_picker_button.dart';
import 'package:flutter/material.dart';

class BasicDetailsForm extends StatelessWidget {
  const BasicDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.templeBasicDetailsLabel,
          style: context.theme.textTheme.titleSmall?.copyWith(
            color: context.colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        AppInputField(
          hint: context.l10n.templeNameLabel,
          labelText: context.l10n.templeNameLabel,
        ),
        AppSpacing.verticalMedium,
        AppInputField(
          hint: context.l10n.mainDeityLabel,
          labelText: context.l10n.mainDeityLabel,
        ),
        AppSpacing.verticalMedium,
        AppInputField(
          hint: context.l10n.otherDeitieslabel,
          labelText: context.l10n.otherDeitieslabel,
        ),
        AppSpacing.verticalMedium,
        AppDropdownMenu<String>(
          hint: context.l10n.chooseOneLabel,
          labelText: context.l10n.managingAuthorityLabel,
          items: [
            DropdownMenuEntry<String>(
              value: context.l10n.devaswomBoardLabel,
              label: context.l10n.devaswomBoardLabel,
            ),
            DropdownMenuEntry<String>(
              value: context.l10n.privateTrustLabel,
              label: context.l10n.privateTrustLabel,
            ),
            DropdownMenuEntry<String>(
              value: context.l10n.familyTrustLabel,
              label: context.l10n.familyTrustLabel,
            ),
            DropdownMenuEntry<String>(
              value: context.l10n.othersLabel,
              label: context.l10n.othersLabel,
            ),
          ],
          onSelected: (value) {},
        ),
        AppSpacing.verticalMedium,
        Text(
          context.l10n.templeSchedulesLabel,
          style: context.theme.textTheme.titleSmall?.copyWith(
            color: context.colors.grey[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        TimeRangePickerButton(labelText: context.l10n.morningScheduleLabel),
        AppSpacing.verticalMedium,
        TimeRangePickerButton(labelText: context.l10n.eveningScheduleLabel),
        AppSpacing.verticalMedium,
        AppInputField(
          hint: context.l10n.templeDescriptionLabel,
          labelText: context.l10n.templeDescriptionLabel,
          maxLines: 5,
        ),
        AppSpacing.verticalMedium,
        AppInputField(
          hint: context.l10n.templeRulesLabel,
          labelText: context.l10n.templeRulesLabel,
          maxLines: 5,
        ),
        AppSpacing.verticalMedium,
      ],
    );
  }
}
