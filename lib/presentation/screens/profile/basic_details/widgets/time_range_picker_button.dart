import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/time_range.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimeRangePickerButton extends HookWidget {
  const TimeRangePickerButton({
    super.key,
    this.labelText,
    this.errorText,
    this.initialRange,
    this.onChanged,
  });

  final String? labelText;
  final String? errorText;
  final TimeRange? initialRange;
  final ValueChanged<TimeRange>? onChanged;

  @override
  Widget build(BuildContext context) {
    final timeRangeNotifier = useState<TimeRange>(initialRange ?? TimeRange());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              labelText!,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: context.colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    builder: (context, child) {
                      return TimePickerTheme(
                        data: TimePickerThemeData(
                          hourMinuteColor: context.colors.primary[50],
                          hourMinuteTextColor: context.colorScheme.primary,
                          dayPeriodColor: context.colors.primary[50],
                          dayPeriodTextColor: context.colorScheme.primary,
                          entryModeIconColor: context.colors.grey[700],
                          dialBackgroundColor: context.colors.grey[50],
                          hourMinuteTextStyle: context
                              .theme
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontFamily: FontFamily.roboto),
                          dialTextStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(fontFamily: FontFamily.roboto),
                        ),
                        child: child!,
                      );
                    },
                    initialTime: TimeOfDay.now(),
                  );

                  timeRangeNotifier.value = timeRangeNotifier.value.copyWith(
                    startTime: pickedTime,
                  );

                  if (timeRangeNotifier.value.startTime != null &&
                      timeRangeNotifier.value.endTime != null) {
                    onChanged?.call(timeRangeNotifier.value);
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: context.colors.grey[50],
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 24,
                      color: context.colors.grey[700],
                    ),
                    AppSpacing.horizontalSmall,
                    Text(
                      timeRangeNotifier.value.startTime != null
                          ? timeRangeNotifier.value.startTime!.format(context)
                          : context.l10n.timePickerLabel,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.grey[700],
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.horizontalSmall,
            SizedBox(width: 5, child: Divider()),
            AppSpacing.horizontalSmall,
            Expanded(
              child: FilledButton(
                onPressed: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    builder: (context, child) {
                      return TimePickerTheme(
                        data: TimePickerThemeData(
                          hourMinuteColor: context.colors.primary[50],
                          hourMinuteTextColor: context.colorScheme.primary,
                          dayPeriodColor: context.colors.primary[50],
                          dayPeriodTextColor: context.colorScheme.primary,
                          entryModeIconColor: context.colors.grey[700],
                          dialBackgroundColor: context.colors.grey[50],
                          hourMinuteTextStyle: context
                              .theme
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontFamily: FontFamily.roboto),
                          dialTextStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(fontFamily: FontFamily.roboto),
                        ),
                        child: child!,
                      );
                    },
                    initialTime: TimeOfDay.now(),
                  );

                  timeRangeNotifier.value = timeRangeNotifier.value.copyWith(
                    endTime: pickedTime,
                  );

                  if (timeRangeNotifier.value.startTime != null &&
                      timeRangeNotifier.value.endTime != null) {
                    onChanged?.call(timeRangeNotifier.value);
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: context.colors.grey[50],
                  minimumSize: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 24,
                      color: context.colors.grey[700],
                    ),
                    AppSpacing.horizontalSmall,
                    Text(
                      timeRangeNotifier.value.endTime != null
                          ? timeRangeNotifier.value.endTime!.format(context)
                          : context.l10n.timePickerLabel,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.grey[700],
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (errorText != null) ...[
          AppSpacing.verticalSmall,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              errorText!,
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: context.colors.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
