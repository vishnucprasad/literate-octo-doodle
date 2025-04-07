import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/advanced_options/advanced_options_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BankDetailsForm extends ConsumerWidget {
  const BankDetailsForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(advancedOptionsControllerProvider);
    final controller = ref.read(advancedOptionsControllerProvider.notifier);

    ref.listen(advancedOptionsControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isSaving == true && !next.isSaving) {
        context.pop();
        context.showSuccessSnackbar(message: context.l10n.successMessage);
      }

      if (previous?.error != next.error) {
        if (error is DatabaseException) {
          context.pop();
          context.showErrorSnackbar(
            message: error.getDatabaseExceptionMessage(context),
          );
        }
      }
    });

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      expand: false,
      maxChildSize: 0.88,
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
                    context.l10n.bankDetailsFormTitle,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    initialValue: state.advancedOptions.bankDetails.bankName,
                    hint: context.l10n.bankNameHintText,
                    labelText: context.l10n.bankNameLabel,
                    errorText: state.validationErrors.bankName?.maybeWhen(
                      empty: () => context.l10n.bankNameEmptyErrorText,
                      invalid: () => context.l10n.bankNameInvalidErrorText,
                      orElse: () => null,
                    ),
                    prefixIcon: Icon(
                      Icons.account_balance_outlined,
                      color: context.colors.grey[700],
                    ),
                    onChanged: controller.updateBankName,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    initialValue:
                        state.advancedOptions.bankDetails.accountNumber,
                    hint: context.l10n.accountNumberHintText,
                    labelText: context.l10n.accountNumberLabel,
                    fontFamily: FontFamily.roboto,
                    errorText: state.validationErrors.accountNumber?.maybeWhen(
                      empty: () => context.l10n.accountNumberEmptyErrorText,
                      invalid: () => context.l10n.accountNumberInvalidErrorText,
                      orElse: () => null,
                    ),
                    prefixIcon: Icon(
                      Icons.credit_card_outlined,
                      color: context.colors.grey[700],
                    ),
                    onChanged: controller.updateAccountNumber,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    initialValue: state.advancedOptions.bankDetails.ifscCode,
                    hint: context.l10n.ifscCodeHintText,
                    labelText: context.l10n.ifscCodeLabel,
                    fontFamily: FontFamily.roboto,
                    errorText: state.validationErrors.ifscCode?.maybeWhen(
                      empty: () => context.l10n.ifscCodeEmptyErrorText,
                      invalid: () => context.l10n.ifscCodeInvalidErrorText,
                      orElse: () => null,
                    ),
                    prefixIcon: Icon(
                      Icons.numbers_outlined,
                      color: context.colors.grey[700],
                    ),
                    onChanged: controller.updateIfscCode,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    initialValue:
                        state.advancedOptions.bankDetails.accountHolderName,
                    hint: context.l10n.accountHolderNameHintText,
                    labelText: context.l10n.accountHolderNameLabel,
                    errorText: state.validationErrors.accountHolderName
                        ?.maybeWhen(
                          empty:
                              () =>
                                  context.l10n.accountHolderNameEmptyErrorText,
                          invalid:
                              () =>
                                  context
                                      .l10n
                                      .accountHolderNameInvalidErrorText,
                          orElse: () => null,
                        ),
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: context.colors.grey[700],
                    ),
                    onChanged: controller.updateAccountHolderName,
                  ),
                  AppSpacing.verticalMedium,
                  if (state.isSaving) ...[
                    Center(
                      child: LinearProgressIndicator(
                        backgroundColor: context.colorScheme.surface,
                      ),
                    ),
                    AppSpacing.verticalSmall,
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
                          onPressed: controller.saveBankDetails,
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
