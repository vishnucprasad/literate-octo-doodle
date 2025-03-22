import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ResetEmailSentDialog extends StatelessWidget {
  const ResetEmailSentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child: Icon(Icons.mail, color: context.colors.white),
      ),
      iconPadding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 24.0),
      title: Text(
        context.l10n.passwordRestLinkSentSuccessTitle,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 32.0),
      content: Text(
        context.l10n.passwordRestLinkSentSuccessMessage,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    );
  }
}
