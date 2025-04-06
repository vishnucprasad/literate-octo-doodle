import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/advanced_options/advanced_options_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdvancedBookingLimitDialog extends HookConsumerWidget {
  const AdvancedBookingLimitDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(advancedOptionsControllerProvider);
    final controller = ref.read(advancedOptionsControllerProvider.notifier);

    final textController = useTextEditingController(
      text: state.advancedOptions.advancedOnlneBookingLimit,
    );

    useEffect(() {
      textController.text = state.advancedOptions.advancedOnlneBookingLimit;
      return null;
    }, [state.advancedOptions.advancedOnlneBookingLimit]);

    ref.listen(advancedOptionsControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isSaving == true && !next.isSaving) {
        context.pop();
        context.showSuccessSnackbar(message: context.l10n.successMessage);
      }

      if (error is DatabaseException) {
        context.pop();
        context.showErrorSnackbar(
          message: error.getDatabaseExceptionMessage(context),
        );
      }
    });

    return AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.all(4.0),
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        context.l10n.advancedBookingLimitDialogTitle,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: context.theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      content: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                controller.updateAdvancedBookingLimit(
                  '${int.parse(state.advancedOptions.advancedOnlneBookingLimit) - 1}',
                );
              },
              style: IconButton.styleFrom(
                backgroundColor: context.colors.primary[50],
              ),
              icon: Icon(Icons.remove, color: context.colorScheme.primary),
            ),
            AppSpacing.horizontalSmall,
            SizedBox(
              width: 50,
              child: AppInputField(
                controller: textController,
                fontFamily: FontFamily.roboto,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
            AppSpacing.horizontalSmall,
            IconButton(
              onPressed: () {
                controller.updateAdvancedBookingLimit(
                  '${int.parse(state.advancedOptions.advancedOnlneBookingLimit) + 1}',
                );
              },
              style: IconButton.styleFrom(
                backgroundColor: context.colors.primary[50],
              ),
              icon: Icon(
                Icons.add_outlined,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: controller.saveAdvancedBookingLimit,
          child: Text(context.l10n.saveButtonLabel),
        ),
      ],
    );
  }
}
