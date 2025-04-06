import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeleteImageConfirmationDialog extends ConsumerWidget {
  const DeleteImageConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(galleryControllerProvider.notifier);

    return AlertDialog(
      icon: CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child: Icon(Icons.question_mark, color: context.colors.white),
      ),
      iconPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      title: Text(
        context.l10n.deleteImagesConfirmationDialogTitle,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
      content: Text(
        context.l10n.deleteImagesConfirmationDialogDescription,
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
          onPressed: () {
            controller.deleteSelectedImages();
            context.pop();
          },
          child: Text(context.l10n.deleteButtonLabel),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    );
  }
}
