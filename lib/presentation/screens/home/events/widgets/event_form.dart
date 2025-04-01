import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/widgets/date_and_time_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventForm extends StatelessWidget {
  const EventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.3,
      expand: false,
      maxChildSize: 0.88,
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
                        context.l10n.addNewEventFormTitle,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            context.l10n.registrationsOpenLabel,
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
                    hint: context.l10n.eventNameHintText,
                    labelText: context.l10n.eventNameLabel,
                    prefixIcon: Icon(
                      Icons.event_outlined,
                      color: context.colors.grey[700],
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppDropdownMenu<String>(
                          hint: context.l10n.chooseOneLabel,
                          labelText: context.l10n.eventTypeLabel,
                          items: [
                            DropdownMenuEntry<String>(
                              value: 'Pooja',
                              label: 'Pooja',
                            ),
                            DropdownMenuEntry<String>(
                              value: 'Special Pooja',
                              label: 'Special Pooja',
                            ),
                          ],
                          onSelected: (value) {},
                        ),
                      ),
                      AppSpacing.horizontalSmall,
                      Expanded(
                        child: AppDropdownMenu<String>(
                          hint: context.l10n.chooseOneLabel,
                          labelText: context.l10n.statusLabel,
                          items: [
                            DropdownMenuEntry<String>(
                              value: context.l10n.activeBadgeLabel,
                              label: context.l10n.activeBadgeLabel,
                            ),
                            DropdownMenuEntry<String>(
                              value: context.l10n.inactiveBadgeLabel,
                              label: context.l10n.inactiveBadgeLabel,
                            ),
                          ],
                          onSelected: (value) {},
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.eventLocationHintText,
                    labelText: context.l10n.eventLocationLabel,
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: context.colors.grey[700],
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  DateAndTimePickerButton(
                    labelText: context.l10n.eventDateAndTimeLabel,
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.eventDescriptionHintText,
                    labelText: context.l10n.eventDescriptionLabel,
                    maxLines: 5,
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
