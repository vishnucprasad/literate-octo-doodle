import 'package:aaraadhya_temple_dashboard/core/enums/pooja_type.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/firebase_storage_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/image_picker_exeception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/poojas_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/pooja_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPoojaForm extends ConsumerWidget {
  const AddPoojaForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poojasControllerProvider);
    final controller = ref.read(poojasControllerProvider.notifier);

    ref.listen(poojasControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isSaving == true && !next.isSaving) {
        context.showSuccessSnackbar(message: context.l10n.successMessage);
        context.pop();
      }

      if (previous?.error != next.error) {
        if (error is DatabaseException) {
          context.showErrorSnackbar(
            message: error.getDatabaseExceptionMessage(context),
          );
        }

        if (error is FirebaseStorageException) {
          context.showErrorSnackbar(
            message: error.getFirebaseStorageExceptionMessage(context),
          );
        }

        if (error is ImagePickerExeception) {
          context.showErrorSnackbar(
            message: error.getImagePickerExeceptionMessage(context),
          );
        }

        context.pop();
      }
    });

    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.mediaQuery.viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: context.width / 4,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  AppSpacing.verticalLarge,
                  Text(
                    context.l10n.addNewPoojaFormTitle,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  PoojaImagePicker(
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.poojaImage?.maybeMap(
                              empty:
                                  (value) =>
                                      context
                                          .l10n
                                          .poojaImageNotSelectedErrorText,
                              orElse: () => null,
                            )
                            : null,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.poojaNameHintText,
                    labelText: context.l10n.poojaNameLabel,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.poojaName?.maybeMap(
                              empty:
                                  (value) =>
                                      context.l10n.poojaNameEmptyErrorText,
                              duplicate:
                                  (value) =>
                                      context.l10n.poojaNameDuplicateErrorText,
                              orElse: () => null,
                            )
                            : null,
                    prefixIcon: Icon(
                      Icons.temple_hindu_outlined,
                      color: context.colors.grey[700],
                    ),
                    onChanged: controller.updatePoojaName,
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<PoojaType>(
                    hint: context.l10n.chooseOneLabel,
                    labelText: context.l10n.poojaTypeLabelText,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.poojaType?.maybeMap(
                              empty:
                                  (value) =>
                                      context
                                          .l10n
                                          .poojaTypeNotSelectedErrorText,
                              orElse: () => null,
                            )
                            : null,
                    items: [
                      DropdownMenuEntry<PoojaType>(
                        value: PoojaType.pooja,
                        label: context.l10n.poojaLabel,
                      ),
                      DropdownMenuEntry<PoojaType>(
                        value: PoojaType.specialPooja,
                        label: context.l10n.specialPoojaLabel,
                      ),
                    ],
                    onSelected: (value) {
                      if (value != null) {
                        controller.updatePoojaType(value);
                      }
                    },
                  ),
                  if (state.pooja.poojaType == PoojaType.specialPooja) ...[
                    AppSpacing.verticalMedium,
                    AppInputField(
                      hint: context.l10n.poojaPurposeHintText,
                      labelText: context.l10n.poojaPurposeLabel,
                      maxLines: 5,
                      onChanged: controller.updatePoojaPurpose,
                    ),
                  ],
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.poojaDescriptionHintText,
                    labelText: context.l10n.poojaDescriptionLabel,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.poojaDescription?.maybeMap(
                              empty:
                                  (value) =>
                                      context
                                          .l10n
                                          .poojaDescriptionEmptyErrorText,
                              orElse: () => null,
                            )
                            : null,
                    maxLines: 5,
                    onChanged: controller.updatePoojaDescription,
                  ),
                  AppSpacing.verticalMedium,
                  if (state.isSaving) ...[
                    LinearProgressIndicator(
                      backgroundColor: context.colorScheme.surface,
                    ),
                    AppSpacing.verticalMedium,
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.colors.error,
                            side: BorderSide(
                              color: context.colors.error,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.cancelButtonLabel),
                        ),
                      ),
                      AppSpacing.horizontalSmall,
                      Expanded(
                        child: FilledButton(
                          onPressed: controller.savePooja,
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.saveButtonLabel),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
