import 'package:aaraadhya_temple_dashboard/core/enums/pooja_time.dart';
import 'package:aaraadhya_temple_dashboard/core/enums/schedule_mode.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/date_and_time_picker_button.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/pooja_schedules_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/repeat_days_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SchedulePoojaForm extends ConsumerWidget {
  const SchedulePoojaForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poojaSchedulesControllerProvider);
    final controller = ref.read(poojaSchedulesControllerProvider.notifier);

    final templeDetails = ref.watch(
      basicDetailsControllerProvider.select((state) => state.basicDetails),
    );

    ref.listen(poojaSchedulesControllerProvider, (previous, next) {
      final error = next.error;

      if (error == null && previous?.isSaving == true && !next.isSaving) {
        context.showSuccessSnackbar(message: context.l10n.successMessage);
        context.pop();
      }

      if (previous?.error != next.error) {
        if (error is DatabaseException) {
          context.showErrorSnackbar(
            message: error.getDatabaseExceptionMessage(context),
          );
          context.pop();
        }
      }
    });

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
                                inactiveTrackColor: context.colors.grey,
                                activeTrackColor: context.colors.primary,
                                inactiveThumbColor: context.colors.grey[700],
                                value: state.schedule.isActive,
                                onChanged: controller.updateStatus,
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
                    initialValue: state.isEditing ? state.schedule.price : null,
                    hint: context.l10n.poojaPriceHintText,
                    labelText: context.l10n.pricelabel,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.price?.maybeMap(
                              empty:
                                  (value) => context.l10n.priceEmptyErrorText,
                              orElse: () => null,
                            )
                            : null,
                    prefixIcon: Icon(
                      Icons.currency_rupee_outlined,
                      color: context.colors.grey[700],
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: controller.updatePrice,
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<String>(
                    labelText: context.l10n.deityLabel,
                    hint:
                        state.isEditing
                            ? state.schedule.deityName
                            : context.l10n.deityHintText,
                    initialSelection:
                        state.isEditing ? state.schedule.deityName : null,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.deityName?.maybeMap(
                              empty:
                                  (value) =>
                                      context.l10n.deityNotSelectedErrorText,
                              orElse: () => null,
                            )
                            : null,
                    items: [
                      DropdownMenuEntry<String>(
                        value: templeDetails.mainDeityName ?? 'NULL',
                        label: templeDetails.mainDeityName ?? 'NULL',
                      ),
                      ...List.generate(
                        templeDetails.otherDeities?.length ?? 0,
                        (index) {
                          return DropdownMenuEntry<String>(
                            value: templeDetails.otherDeities![index],
                            label: templeDetails.otherDeities![index],
                          );
                        },
                      ),
                    ],
                    onSelected: (value) {
                      if (value != null) {
                        controller.updateDeityName(value);
                      }
                    },
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<ScheduleMode>(
                    labelText: context.l10n.scheduleModeLabel,
                    hint: context.l10n.scheduleModeHintText,
                    initialSelection:
                        state.isEditing ? state.schedule.scheduleMode : null,
                    errorText:
                        state.validationErrors.showValidationErrors
                            ? state.validationErrors.scheduleMode?.maybeMap(
                              empty:
                                  (value) =>
                                      context
                                          .l10n
                                          .scheduleModeNotSelectedErrorText,
                              orElse: () => null,
                            )
                            : null,
                    items: [
                      DropdownMenuEntry<ScheduleMode>(
                        value: ScheduleMode.repeat,
                        label: context.l10n.repeatModeLabel,
                      ),
                      DropdownMenuEntry<ScheduleMode>(
                        value: ScheduleMode.once,
                        label: context.l10n.onceOnlyModeLabel,
                      ),
                    ],
                    onSelected: controller.updateScheduleMode,
                  ),
                  AppSpacing.verticalMedium,
                  if (state.schedule.scheduleMode == ScheduleMode.repeat) ...[
                    RepeatDaysPicker(
                      labelText: context.l10n.poojaDaysLabel,
                      errorText:
                          state.validationErrors.showValidationErrors
                              ? state.validationErrors.poojaDays?.maybeMap(
                                empty:
                                    (value) =>
                                        context
                                            .l10n
                                            .poojaDaysNotSelectedErrorText,
                                orElse: () => null,
                              )
                              : null,
                      initialSelected: state.schedule.poojaDays,
                      onChanged: controller.updatePoojaDays,
                    ),
                    AppSpacing.verticalMedium,
                    AppDropdownMenu<PoojaTime>(
                      labelText: context.l10n.poojaTimeLabel,
                      hint: context.l10n.poojaTimeHintText,
                      initialSelection:
                          state.isEditing ? state.schedule.poojaTime : null,
                      errorText:
                          state.validationErrors.showValidationErrors
                              ? state.validationErrors.poojaTime?.maybeMap(
                                empty:
                                    (value) =>
                                        context
                                            .l10n
                                            .poojaTimeNotSelectedErrorText,
                                orElse: () => null,
                              )
                              : null,
                      items: [
                        DropdownMenuEntry<PoojaTime>(
                          value: PoojaTime.morning,
                          label: context.l10n.morningLabel,
                        ),
                        DropdownMenuEntry<PoojaTime>(
                          value: PoojaTime.evening,
                          label: context.l10n.eveningLabel,
                        ),
                      ],
                      onSelected: controller.updatePoojaTime,
                    ),
                    AppSpacing.verticalMedium,
                  ],
                  if (state.schedule.scheduleMode == ScheduleMode.once) ...[
                    DateAndTimePickerButton(
                      labelText: context.l10n.poojaDateAndTimeLabel,
                      hintText: context.l10n.poojaDateAndTimeHintText,
                      initialDateTime:
                          state.isEditing
                              ? state.schedule.poojaDateAndTime
                              : null,
                      errorText:
                          state.validationErrors.showValidationErrors
                              ? state.validationErrors.poojaDateAndTime
                                  ?.maybeMap(
                                    empty:
                                        (value) =>
                                            context
                                                .l10n
                                                .poojaDateTimeEmptyErrorText,
                                    orElse: () => null,
                                  )
                              : null,
                      onChanged: controller.updatePoojaDateTime,
                    ),
                    AppSpacing.verticalMedium,
                  ],
                  if (state.isSaving) ...[
                    LinearProgressIndicator(
                      backgroundColor: context.colorScheme.surface,
                    ),
                    AppSpacing.verticalMedium,
                  ],
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
                          onPressed: controller.schedulePooja,
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
