import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/assets.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SizedBox(
            width: double.infinity,
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
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppSpacing.verticalLarge,
                AppInputField(
                  hint: context.l10n.emailHint,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: context.colorScheme.primary,
                  ),
                ),
                AppSpacing.verticalMedium,
                AppInputField(
                  hint: context.l10n.passwordHint,
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: context.colorScheme.primary,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.visibility_off_outlined,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
                AppSpacing.verticalSmall,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      context.l10n.forgotPasswordQuestion,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                AppSpacing.verticalSmall,
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: Text(context.l10n.signinText.toUpperCase()),
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
