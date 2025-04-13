import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/change_password/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordForm extends HookConsumerWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCurrentPasswordVisible = useState(false);
    final isNewPasswordVisible = useState(false);
    final isConfirmPasswordVisible = useState(false);

    final state = ref.watch(changePasswordControllerProvider);
    final controller = ref.read(changePasswordControllerProvider.notifier);

    ref.listen(changePasswordControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isChanging == true && !next.isChanging) {
        context.pop();
        context.showSuccessSnackbar(message: context.l10n.successMessage);
      }

      if (previous?.error != next.error) {
        if (error is AuthException) {
          context.pop();
          context.showErrorSnackbar(
            message: error.getAuthExceptionMessage(context),
          );
        }
      }
    });

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
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
                    context.l10n.changeAccountPasswordFormTitle,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.currentPasswordHintText,
                    labelText: context.l10n.currentPasswordLabel,
                    errorText:
                        state.showValidationErrors
                            ? state.currentPasswordValidationError?.maybeWhen(
                              empty:
                                  () =>
                                      context
                                          .l10n
                                          .emptyPasswordValidationErorrMessage,
                              invalid:
                                  () =>
                                      context
                                          .l10n
                                          .invalidPasswordValidationErorrMessage,
                              orElse: () => null,
                            )
                            : null,
                    obscureText: !isCurrentPasswordVisible.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: context.colors.grey[700],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isCurrentPasswordVisible.value =
                            !isCurrentPasswordVisible.value;
                      },
                      icon: Icon(
                        isCurrentPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: context.colors.grey[700],
                      ),
                    ),
                    onChanged: controller.updateCurrentPassword,
                  ),
                  AppSpacing.verticalMedium,
                  Center(
                    child: SizedBox(
                      width: context.width / 3,
                      child: Divider(color: context.colorScheme.primary),
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.newPassWordHintText,
                    labelText: context.l10n.newPasswordLabel,
                    errorText:
                        state.showValidationErrors
                            ? state.newPasswordValidationError?.maybeWhen(
                              empty:
                                  () =>
                                      context
                                          .l10n
                                          .emptyPasswordValidationErorrMessage,
                              invalid:
                                  () =>
                                      context
                                          .l10n
                                          .invalidPasswordValidationErorrMessage,
                              orElse: () => null,
                            )
                            : null,
                    obscureText: !isNewPasswordVisible.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: context.colors.grey[700],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isNewPasswordVisible.value =
                            !isNewPasswordVisible.value;
                      },
                      icon: Icon(
                        isNewPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: context.colors.grey[700],
                      ),
                    ),
                    onChanged: controller.updateNewPassword,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.confirmPasswordHintText,
                    labelText: context.l10n.confirmPasswordLabel,
                    errorText:
                        state.showValidationErrors
                            ? state.confirmPasswordValidationError?.maybeWhen(
                              notMatched:
                                  () =>
                                      context.l10n.passwordsDoNotMatchErrorText,
                              orElse: () => null,
                            )
                            : null,
                    obscureText: !isConfirmPasswordVisible.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: context.colors.grey[700],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isConfirmPasswordVisible.value =
                            !isConfirmPasswordVisible.value;
                      },
                      icon: Icon(
                        isConfirmPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: context.colors.grey[700],
                      ),
                    ),
                    onChanged: controller.updateConfirmPassword,
                  ),
                  AppSpacing.verticalMedium,
                  if (state.isChanging) ...[
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
                          onPressed: controller.changePassword,
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.changePasswordLabel),
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
