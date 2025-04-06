import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/firebase_storage_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/image_picker_exeception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/widgets/gallery_action_buttons.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/widgets/gallery_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(galleryControllerProvider, (previous, next) {
      final error = next.error;

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
    });

    return Column(
      children: [
        AppSpacing.verticalMedium,
        Expanded(child: GalleryGridView()),
        AppSpacing.verticalMedium,
        GalleryActionButtons(),
      ],
    );
  }
}
