import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/contact_details/contact_details_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/contact_details/widgets/contact_details_action_buttons.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/contact_details/widgets/contact_text_field_group.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactDetailsScreen extends ConsumerWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactDetailsControllerProvider);
    final controller = ref.read(contactDetailsControllerProvider.notifier);

    ref.listen(contactDetailsControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isSaving == true && !next.isSaving) {
        context.showSuccessSnackbar(message: context.l10n.successMessage);
      }

      if (previous?.error != next.error) {
        if (error is DatabaseException) {
          context.showErrorSnackbar(
            message: error.getDatabaseExceptionMessage(context),
          );
        }
      }
    });

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            AppSpacing.verticalMedium,
            ShimmerLoader(
              isLoading: state.isLoading,
              showBackground: true,
              child: Text(
                context.l10n.templeCommiteeMembersLabel,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppSpacing.verticalMedium,
            ShimmerLoader(
              isLoading: state.isLoading,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.contactDetails.committeeMembers.length,
                itemBuilder: (context, index) {
                  return ContactTextFieldGroup(index: index);
                },
                separatorBuilder: (context, index) => AppSpacing.verticalSmall,
              ),
            ),
            if (state.isFormEnabled) ...[
              SizedBox(
                height: 40,
                child: FilledButton(
                  onPressed: controller.addNewCommitteeMember,
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
            ],
            ShimmerLoader(
              isLoading: state.isLoading,
              showBackground: true,
              child: Text(
                context.l10n.chiefPriestLabel,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppSpacing.verticalMedium,
            ShimmerLoader(
              isLoading: state.isLoading,
              child: Row(
                children: [
                  Expanded(
                    child: AppInputField(
                      enabled: state.isFormEnabled,
                      initialValue: state.contactDetails.chiefPriest.name,
                      hint: context.l10n.nameLabel,
                      onChanged: controller.updateCheifPriestName,
                    ),
                  ),
                  AppSpacing.horizontalSmall,
                  Expanded(
                    child: AppInputField(
                      enabled: state.isFormEnabled,
                      initialValue:
                          state.contactDetails.chiefPriest.phoneNumber,
                      hint: context.l10n.numberLabel,
                      fontFamily: FontFamily.roboto,
                      onChanged: controller.updateCheifPriestNumber,
                    ),
                  ),
                ],
              ),
            ),
            if (state.validationErrors.chiefPriest.hasErrors) ...[
              AppSpacing.verticalSmall,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Text(
                  state.validationErrors.chiefPriest.name?.maybeMap(
                        empty: (value) => context.l10n.nameEmptyErrorText,
                        invalid: (value) => context.l10n.nameInvalidErrorText,
                        orElse: () => null,
                      ) ??
                      state.validationErrors.chiefPriest.phoneNumber?.maybeMap(
                        empty:
                            (value) => context.l10n.phoneNumberEmptyErrorText,
                        invalid:
                            (value) => context.l10n.phoneNumberInvalidErrorText,
                        orElse: () => null,
                      ) ??
                      '',
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    color: context.theme.colorScheme.error,
                    fontFamily: FontFamily.roboto,
                  ),
                ),
              ),
            ],
            AppSpacing.verticalMedium,
            ShimmerLoader(
              isLoading: state.isLoading,
              child: Text(
                context.l10n.moreDetailsLabel,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  color: context.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppSpacing.verticalMedium,
            ShimmerLoader(
              isLoading: state.isLoading,
              child: Column(
                children: [
                  AppInputField(
                    enabled: state.isFormEnabled,
                    initialValue: state.contactDetails.address,
                    hint: context.l10n.addressHintText,
                    labelText: context.l10n.addressLabel,
                    errorText: state.validationErrors.address?.maybeMap(
                      empty: (value) => context.l10n.addressEmptyErrorText,
                      orElse: () => null,
                    ),
                    onChanged: controller.updateAddress,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    enabled: state.isFormEnabled,
                    initialValue: state.contactDetails.locationLink,
                    hint: context.l10n.locationLinkHintText,
                    labelText: context.l10n.locationLinkLabel,
                    errorText: state.validationErrors.locationLink?.maybeMap(
                      empty: (value) => context.l10n.locationLinkErrorText,
                      invalid:
                          (value) => context.l10n.locationLinkInvalidErrorText,
                      orElse: () => null,
                    ),
                    onChanged: controller.updateLocationLink,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    enabled: state.isFormEnabled,
                    initialValue: state.contactDetails.websiteLink,
                    hint: context.l10n.websiteLinkHintText,
                    labelText: context.l10n.websiteLinkLabel,
                    errorText: state.validationErrors.websiteLink?.maybeMap(
                      invalid:
                          (value) => context.l10n.websiteLinkInvalidErrorText,
                      orElse: () => null,
                    ),
                    onChanged: controller.updateWebsiteLink,
                  ),
                ],
              ),
            ),
            AppSpacing.verticalFromPixels(state.isFormEnabled ? 100.0 : 16.0),
          ],
        ),
        ContactDetailsActionButtons(),
      ],
    );
  }
}
