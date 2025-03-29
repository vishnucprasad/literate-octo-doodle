import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DateAndTimePickerButton extends HookWidget {
  const DateAndTimePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDateAndTimeNotifier = useState<DateTime?>(null);

    return FilledButton(
      onPressed: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return DatePickerTheme(
              data: DatePickerThemeData(
                headerBackgroundColor: context.colors.primary[50],
                headerForegroundColor: context.colorScheme.primary,
                headerHeadlineStyle: context.theme.textTheme.headlineLarge
                    ?.copyWith(fontFamily: FontFamily.roboto),
                headerHelpStyle: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                ),
                dayStyle: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                ),
                yearStyle: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                ),
                dividerColor: context.colorScheme.primary,
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null && context.mounted) {
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
                  hourMinuteTextStyle: context.theme.textTheme.displayLarge
                      ?.copyWith(fontFamily: FontFamily.roboto),
                  dialTextStyle: context.theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.roboto,
                  ),
                ),
                child: child!,
              );
            },
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null) {
            selectedDateAndTimeNotifier.value = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
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
          AppSpacing.horizontalSmall,
          Text(
            selectedDateAndTimeNotifier.value != null
                ? DateFormat(
                  "MMMM d, y • h:mm a",
                ).format(selectedDateAndTimeNotifier.value!)
                : context.l10n.eventDateAndTimeLabel,
            style: context.theme.textTheme.bodyMedium?.copyWith(
              color: context.colors.grey[700],
              fontFamily: FontFamily.roboto,
            ),
          ),
          Spacer(),
          Icon(Icons.event_outlined, size: 24, color: context.colors.grey[700]),
        ],
      ),
    );
  }
}
