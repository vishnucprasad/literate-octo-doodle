import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/assets.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/signin/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SigninScreen extends HookConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPasswordVisible = useState<bool>(false);

    final state = ref.watch(signinControllerProvider);
    final controller = ref.read(signinControllerProvider.notifier);

    ref.listen(signinControllerProvider.select((value) => value.error), (
      _,
      error,
    ) {
      if (error != null) {
        context.showErrorSnackbar(
          message: error.maybeWhen(
            invalidCredential:
                () => context.l10n.invalidCredentialsErrorMessage,
            tooManyRequests: () => context.l10n.tooManyRequestsErrorMessage,
            userDisabled: () => context.l10n.userDisabledErrorMessage,
            generic: (message) => message,
            unexpected: (error) => error,
            orElse: () => context.l10n.defaultErrorMessage,
          ),
        );
      }
    });

    final emailValidationErrorText = state.validationErrors.email?.when(
      empty: () => context.l10n.emptyEmailValidationErorrMessage,
      invalid: () => context.l10n.invalidEmailValidationErorrMessage,
    );

    final passwordValidationErrorText = state.validationErrors.password?.when(
      empty: () => context.l10n.emptyPasswordValidationErorrMessage,
      invalid: () => context.l10n.invalidPasswordValidationErorrMessage,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpacing.verticalLarge,
                  Image.asset(
                    height: 80,
                    Assets.images.aaraadhyaLogo.path,
                    color: context.colorScheme.primary,
                  ),
                  AppSpacing.verticalLarge,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.l10n.signinText,
                      style: context.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AppSpacing.verticalLarge,
                  AppInputField(
                    hint: context.l10n.emailHint,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? emailValidationErrorText
                            : null,
                    prefixIcon: Icon(
                      Icons.mail,
                      color: context.colors.grey[700],
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: controller.updateEmail,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.passwordHint,
                    obscureText: !isPasswordVisible.value,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? passwordValidationErrorText
                            : null,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: context.colors.grey[700],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: context.colors.grey[700],
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: controller.updatePassword,
                  ),
                  AppSpacing.verticalSmall,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.push(AppRoutes.forgotPassword.path);
                      },
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        overlayColor: Colors.transparent,
                      ),
                      child: Text(
                        context.l10n.forgotPasswordQuestion,
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.verticalSmall,
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: controller.signin,
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
                              : Text(context.l10n.signinText.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
