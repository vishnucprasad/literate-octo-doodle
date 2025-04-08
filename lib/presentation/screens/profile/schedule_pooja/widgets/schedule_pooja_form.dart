import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/date_and_time_picker_button.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/repeat_days_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SchedulePoojaForm extends StatelessWidget {
  const SchedulePoojaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.mediaQuery.viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: context.width / 4,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  AppSpacing.verticalLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.schedulePoojaAppBarTitle,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            context.l10n.activeBadgeLabel,
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSpacing.horizontalSmall,
                          SizedBox(
                            width: 40,
                            child: Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: true,
                                onChanged: (value) {},
                                padding: EdgeInsets.zero,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.poojaPriceHintText,
                    labelText: context.l10n.pricelabel,
                    prefixIcon: Icon(
                      Icons.currency_rupee_outlined,
                      color: context.colors.grey[700],
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<String>(
                    labelText: context.l10n.deityLabel,
                    hint: context.l10n.deityHintText,
                    items: [
                      DropdownMenuEntry<String>(
                        value: 'Main Deity',
                        label: 'Main Deity',
                      ),
                      DropdownMenuEntry<String>(
                        value: 'Deity 1',
                        label: 'Deity 1',
                      ),
                      DropdownMenuEntry<String>(
                        value: 'Deity 2',
                        label: 'Deity 2',
                      ),
                    ],
                    onSelected: (value) {},
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<String>(
                    labelText: context.l10n.scheduleModeLabel,
                    hint: context.l10n.scheduleModeHintText,
                    items: [
                      DropdownMenuEntry<String>(
                        value: context.l10n.repeatModeLabel,
                        label: context.l10n.repeatModeLabel,
                      ),
                      DropdownMenuEntry<String>(
                        value: context.l10n.onceOnlyModeLabel,
                        label: context.l10n.onceOnlyModeLabel,
                      ),
                    ],
                    onSelected: (value) {},
                  ),
                  AppSpacing.verticalMedium,
                  RepeatDaysPicker(
                    labelText: context.l10n.poojaDaysLabel,
                    initialSelected: List.generate(7, (index) {
                      if (index == DateTime.now().weekday) {
                        return true;
                      }
                      return false;
                    }),
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<String>(
                    labelText: context.l10n.poojaTimeLabel,
                    hint: context.l10n.poojaTimeHintText,
                    items: [
                      DropdownMenuEntry<String>(
                        value: context.l10n.morningLabel,
                        label: context.l10n.morningLabel,
                      ),
                      DropdownMenuEntry<String>(
                        value: context.l10n.eveningLabel,
                        label: context.l10n.eveningLabel,
                      ),
                    ],
                    onSelected: (value) {},
                  ),
                  AppSpacing.verticalMedium,
                  DateAndTimePickerButton(
                    labelText: context.l10n.poojaDateAndTimeLabel,
                    hintText: context.l10n.poojaDateAndTimeHintText,
                  ),
                  AppSpacing.verticalMedium,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.colors.error,
                            side: BorderSide(
                              color: context.colors.error,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.cancelButtonLabel),
                        ),
                      ),
                      AppSpacing.horizontalSmall,
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.saveButtonLabel),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
