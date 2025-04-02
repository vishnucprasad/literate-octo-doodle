import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdvancedBookingLimitDialog extends HookWidget {
  const AdvancedBookingLimitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: '30');

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
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: context.colors.primary[50],
              ),
              icon: Icon(Icons.remove, color: context.colorScheme.primary),
            ),
            AppSpacing.horizontalSmall,
            SizedBox(
              width: 50,
              child: AppInputField(
                controller: controller,
                fontFamily: FontFamily.roboto,
                textAlign: TextAlign.center,
              ),
            ),
            AppSpacing.horizontalSmall,
            IconButton(
              onPressed: () {},
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
        TextButton(onPressed: () {}, child: Text(context.l10n.saveButtonLabel)),
      ],
    );
  }
}
