import 'package:aaraadhya_temple_dashboard/core/enums/temple_managing_authority.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/time_range_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show HookConsumerWidget;

class BasicDetailsForm extends HookConsumerWidget {
  const BasicDetailsForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(basicDetailsControllerProvider);
    final controller = ref.read(basicDetailsControllerProvider.notifier);

    return ShimmerLoader(
      isLoading: state.isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoader(
            isLoading: state.isLoading,
            showBackground: true,
            child: Text(
              context.l10n.templeBasicDetailsLabel,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            enabled: state.isFormEnabled,
            initialValue: state.basicDetails.templeName,
            hint: context.l10n.templeNameHintText,
            labelText: context.l10n.templeNameLabel,
            errorText: state.validationErrors.templeName?.maybeMap(
              empty: (value) => context.l10n.templeNameEmptyErrorText,
              invalid: (value) => context.l10n.templeNameInvalidErrorText,
              orElse: () => null,
            ),
            onChanged: controller.updateTempleName,
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            enabled: state.isFormEnabled,
            initialValue: state.basicDetails.mainDeityName,
            hint: context.l10n.mainDeityHintText,
            labelText: context.l10n.mainDeityLabel,
            errorText: state.validationErrors.mainDeityName?.maybeMap(
              empty: (value) => context.l10n.mainDeityNameEmptyErrorText,
              invalid: (value) => context.l10n.mainDeityNameInvalidErrorText,
              orElse: () => null,
            ),
            onChanged: controller.updateMainDeityName,
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            enabled: state.isFormEnabled,
            initialValue: state.basicDetails.otherDeities?.join(','),
            hint: context.l10n.otherDeitiesHintText,
            labelText: context.l10n.otherDeitieslabel,
            errorText: state.validationErrors.otherDeities?.maybeMap(
              empty: (value) => context.l10n.otherDeitiesEmptyErrorText,
              orElse: () => null,
            ),
            onChanged: controller.updateOtherDeities,
          ),
          AppSpacing.verticalMedium,
          AppDropdownMenu<TempleManagingAuthority>(
            enabled: state.isFormEnabled,
            hint:
                state.basicDetails.managingAuthority?.getName(context) ??
                context.l10n.chooseOneLabel,
            labelText: context.l10n.managingAuthorityLabel,
            errorText: state.validationErrors.managingAuthority?.maybeMap(
              empty: (value) => context.l10n.managingAuthorityEmptyErrorText,
              orElse: () => null,
            ),
            items: [
              DropdownMenuEntry<TempleManagingAuthority>(
                value: TempleManagingAuthority.devaswomBoard,
                label: context.l10n.devaswomBoardLabel,
              ),
              DropdownMenuEntry<TempleManagingAuthority>(
                value: TempleManagingAuthority.privateTrust,
                label: context.l10n.privateTrustLabel,
              ),
              DropdownMenuEntry<TempleManagingAuthority>(
                value: TempleManagingAuthority.familyTrust,
                label: context.l10n.familyTrustLabel,
              ),
              DropdownMenuEntry<TempleManagingAuthority>(
                value: TempleManagingAuthority.others,
                label: context.l10n.othersLabel,
              ),
            ],
            onSelected: (value) {
              if (value != null) {
                controller.updateManagingAuthority(value);
              }
            },
          ),
          AppSpacing.verticalMedium,
          ShimmerLoader(
            isLoading: state.isLoading,
            showBackground: true,
            child: Text(
              context.l10n.templeSchedulesLabel,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppSpacing.verticalMedium,
          TimeRangePickerButton(
            initialRange: state.basicDetails.morningSchedule,
            labelText: context.l10n.morningScheduleLabel,
            errorText: state.validationErrors.morningSchedule?.maybeMap(
              empty: (value) => context.l10n.morningScheduleEmptyErrorText,
              orElse: () => null,
            ),
            enabled: state.isFormEnabled,
            onChanged: controller.updateMorningSchedule,
          ),
          AppSpacing.verticalMedium,
          TimeRangePickerButton(
            initialRange: state.basicDetails.eveningSchedule,
            labelText: context.l10n.eveningScheduleLabel,
            errorText: state.validationErrors.eveningSchedule?.maybeMap(
              empty: (value) => context.l10n.eveningScheduleEmptyErrorText,
              orElse: () => null,
            ),
            enabled: state.isFormEnabled,
            onChanged: controller.updateEveningSchedule,
          ),
          AppSpacing.verticalMedium,
          ShimmerLoader(
            isLoading: state.isLoading,
            showBackground: true,
            child: Text(
              context.l10n.moreDetailsLabel,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            initialValue: state.basicDetails.amenities?.join(','),
            hint: context.l10n.templeAmenitiesHintText,
            labelText: context.l10n.templeAmenitiesLabel,
            errorText: state.validationErrors.amenities?.maybeMap(
              empty: (value) => context.l10n.templeAmenitiesEmptyErrorText,
              orElse: () => null,
            ),
            enabled: state.isFormEnabled,
            onChanged: controller.updateAmenities,
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            initialValue: state.basicDetails.templeHistory,
            hint: context.l10n.templeHistoryHintText,
            labelText: context.l10n.templeHistoryLabel,
            errorText: state.validationErrors.templeHistory?.maybeMap(
              empty: (value) => context.l10n.templeHistoryEmptyErrorText,
              orElse: () => null,
            ),
            maxLines: 5,
            enabled: state.isFormEnabled,
            onChanged: controller.updateTempleHistory,
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            initialValue: state.basicDetails.description,
            hint: context.l10n.templeDescriptionHintText,
            labelText: context.l10n.templeDescriptionLabel,
            errorText: state.validationErrors.description?.maybeMap(
              empty: (value) => context.l10n.templeDescriptionEmptyErrorText,
              orElse: () => null,
            ),
            maxLines: 5,
            enabled: state.isFormEnabled,
            onChanged: controller.updateTempleDescription,
          ),
          AppSpacing.verticalMedium,
          AppInputField(
            initialValue: state.basicDetails.rules,
            hint: context.l10n.templeRulesHintText,
            labelText: context.l10n.templeRulesLabel,
            errorText: state.validationErrors.rules?.maybeMap(
              empty: (value) => context.l10n.templeRulesEmptyErrorText,
              orElse: () => null,
            ),
            maxLines: 5,
            enabled: state.isFormEnabled,
            onChanged: controller.updateRules,
          ),
          AppSpacing.verticalMedium,
        ],
      ),
    );
  }
}
