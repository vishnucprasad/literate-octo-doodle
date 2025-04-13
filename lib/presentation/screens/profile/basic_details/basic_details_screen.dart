import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/firebase_storage_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/image_picker_exeception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/basic_details_action_buttons.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/basic_details_form.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/profile_picture_container.dart';
import 'package:flutter/material.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicDetailsScreen extends ConsumerWidget {
  const BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(basicDetailsControllerProvider);
    ref.listen(basicDetailsControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isSaving == true && !next.isSaving) {
        context.showSuccessSnackbar(message: context.l10n.successMessage);
      }

      if (previous?.error != next.error) {
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
      }
    });

    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            AppSpacing.verticalMedium,
            ProfilePictureContainer(),
            AppSpacing.verticalMedium,
            BasicDetailsForm(),
            SizedBox(height: state.isFormEnabled ? 100.0 : 16.0),
          ],
        ),
        BasicDetailsActionButtons(),
      ],
    );
  }
}
