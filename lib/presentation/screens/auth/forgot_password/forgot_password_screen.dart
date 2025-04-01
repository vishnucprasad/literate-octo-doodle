import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_back_button.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/forgot_password/forgot_password_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/forgot_password/widgets/reset_email_sent_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgotPasswordControllerProvider);
    final controller = ref.read(forgotPasswordControllerProvider.notifier);

    ref.listen(
      forgotPasswordControllerProvider.select((value) => value.error),
      (_, error) {
        if (error != null) {
          context.showErrorSnackbar(
            message: error.maybeWhen(
              invalidEmail: () => context.l10n.invalidEmailErrorMessage,
              userNotFound: () => context.l10n.userNotFoundErrorMessage,
              generic: (message) => message,
              unexpected: (error) => error,
              orElse: () => context.l10n.defaultErrorMessage,
            ),
          );
        }
      },
    );

    final emailValidationErrorText = state.validationErrors.email?.when(
      empty: () => context.l10n.emptyEmailValidationErorrMessage,
      invalid: () => context.l10n.invalidEmailValidationErorrMessage,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                AppSpacing.verticalSmall,
                Align(alignment: Alignment.centerLeft, child: AppBackButton()),
                AppSpacing.verticalMedium,
                Text(
                  context.l10n.forgotPasswordScreenTitle,
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSpacing.verticalSmall,
                Text(
                  context.l10n.forgotPasswordScreenSubtitle,
                  style: context.theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.verticalLarge,
                AppInputField(
                  hint: context.l10n.emailHint,
                  errorText:
                      state.validationErrors.showValidationErrors
                          ? emailValidationErrorText
                          : null,
                  prefixIcon: Icon(Icons.mail, color: context.colors.grey[700]),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: controller.updateEmail,
                ),
                AppSpacing.verticalLarge,
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () async {
                      if (await controller.resetPassword()) {
                        if (context.mounted) {
                          await showDialog(
                            context: context,
                            builder: (context) => ResetEmailSentDialog(),
                          );
                          if (context.mounted) context.pop();
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child:
                        state.isSubmitting
                            ? SizedBox.square(
                              dimension: 24,
                              child: CircularProgressIndicator(
                                color: context.colorScheme.surface,
                              ),
                            )
                            : Text(
                              context.l10n.resetPasswordButtonLabel
                                  .toUpperCase(),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
