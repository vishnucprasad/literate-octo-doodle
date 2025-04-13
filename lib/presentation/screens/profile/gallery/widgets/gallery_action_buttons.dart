import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/widgets/delete_image_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryActionButtons extends ConsumerWidget {
  const GalleryActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleryControllerProvider);
    final controller = ref.read(galleryControllerProvider.notifier);

    return Container(
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(top: BorderSide(color: context.colors.grey, width: 0.5)),
      ),
      child: Column(
        children: [
          if (state.isUploading || state.isDeleting) ...[
            LinearProgressIndicator(
              backgroundColor: context.colorScheme.surface,
            ),
          ],
          AppSpacing.verticalMedium,
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    if (!controller.isAnySelected) {
                      return context.showErrorSnackbar(
                        message: context.l10n.noImagesSelectedToDeleteErrorText,
                      );
                    }

                    showDialog(
                      context: context,
                      builder: (context) => DeleteImageConfirmationDialog(),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colors.error,
                    side: BorderSide(color: context.colors.error, width: 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  icon: Icon(Icons.delete_outline),
                  label: Text(context.l10n.deleteButtonLabel),
                ),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: FilledButton.icon(
                  onPressed: controller.uploadImageToGallery,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  icon: Icon(Icons.upload_outlined),
                  label: Text(context.l10n.uploadButtonLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
