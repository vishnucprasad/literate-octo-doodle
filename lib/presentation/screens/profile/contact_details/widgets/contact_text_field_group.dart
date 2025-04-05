import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/contact_details/contact_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactTextFieldGroup extends ConsumerWidget {
  const ContactTextFieldGroup({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactDetailsControllerProvider);
    final controller = ref.watch(contactDetailsControllerProvider.notifier);

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
            Expanded(
              child: AppInputField(
                initialValue: state.contactDetails.committeeMembers[index].name,
                hint: context.l10n.nameLabel,
                onChanged: (name) {
                  controller.updateCommitteeMemberName(name, index: index);
                },
              ),
            ),
            AppSpacing.horizontalSmall,
            Expanded(
              child: AppInputField(
                initialValue:
                    state.contactDetails.committeeMembers[index].phoneNumber,
                hint: context.l10n.numberLabel,
                fontFamily: FontFamily.roboto,
                onChanged: (number) {
                  controller.updateCommitteeMemberNumber(number, index: index);
                },
              ),
            ),
          ],
        ),
        if (state.validationErrors.committeeMembers[index].hasErrors) ...[
          AppSpacing.verticalSmall,
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              state.validationErrors.committeeMembers[index].name?.maybeMap(
                    empty: (value) => context.l10n.nameEmptyErrorText,
                    invalid: (value) => context.l10n.nameInvalidErrorText,
                    orElse: () => null,
                  ) ??
                  state.validationErrors.committeeMembers[index].phoneNumber
                      ?.maybeMap(
                        empty:
                            (value) => context.l10n.phoneNumberEmptyErrorText,
                        invalid:
                            (value) => context.l10n.phoneNumberInvalidErrorText,
                        orElse: () => null,
                      ) ??
                  '',
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: context.theme.colorScheme.error,
                fontFamily: FontFamily.roboto,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
