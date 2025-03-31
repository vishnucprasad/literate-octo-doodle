import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class ContactTextFieldGroup extends StatelessWidget {
  const ContactTextFieldGroup({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            context.l10n.personLabelWithCount(index + 1),
            style: context.theme.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.roboto,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(child: AppInputField(hint: context.l10n.nameLabel)),
            AppSpacing.horizontalSmall,
            Expanded(child: AppInputField(hint: context.l10n.numberLabel)),
          ],
        ),
      ],
    );
  }
}
