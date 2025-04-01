import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignoutConfirmationDialog extends ConsumerWidget {
  const SignoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return AlertDialog(
      icon: CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child:
            state.isSigningOut
                ? SizedBox.square(
                  dimension: 24.0,
                  child: CircularProgressIndicator(
                    color: context.colorScheme.onPrimary,
                  ),
                )
                : Icon(Icons.question_mark, color: context.colors.white),
      ),
      iconPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      title: Text(
        context.l10n.signoutConfirmationDialogTitle,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
      content: Text(
        context.l10n.signoutConfirmationDialogDescription,
        textAlign: TextAlign.center,
      ),
      actionsPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(foregroundColor: context.colors.error),
          child: Text(context.l10n.cancelButtonLabel),
        ),
        TextButton(
          onPressed: () async {
            await controller.signOut();
          },
          child: Text(context.l10n.signOutTileLabel),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    );
  }
}
