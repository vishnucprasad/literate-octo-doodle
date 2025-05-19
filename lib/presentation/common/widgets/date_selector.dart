import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/date_list/date_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateSelector extends ConsumerWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dateListControllerProvider);
    final controller = ref.watch(dateListControllerProvider.notifier);

    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: context.colors.grey[50],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(state.dateList.length, (index) {
            bool isSelected = state.selectedDateIndex == index;
            return IconButton(
              onPressed: () async {
                if (index == 0) {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 1, 1),
                    lastDate: DateTime(DateTime.now().year + 1, 12, 31),
                    initialDate: DateTime.now(),
                    builder: (context, child) {
                      return DatePickerTheme(
                        data: DatePickerThemeData(
                          headerBackgroundColor: context.colors.primary[50],
                          headerForegroundColor: context.colorScheme.primary,
                          headerHeadlineStyle: context
                              .theme
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontFamily: FontFamily.roboto),
                          headerHelpStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(fontFamily: FontFamily.roboto),
                          dayStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(fontFamily: FontFamily.roboto),
                          yearStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(fontFamily: FontFamily.roboto),
                          dividerColor: context.colorScheme.primary,
                        ),
                        child: child!,
                      );
                    },
                  );

                  return controller.selectDate(index: index, date: date);
                }

                controller.selectDate(index: index);
              },
              style: IconButton.styleFrom(
                overlayColor: context.colorScheme.primary,
              ),
              icon: CircleAvatar(
                radius: isSelected ? 26 : 22,
                backgroundColor:
                    isSelected ? context.colors.primary[50] : Colors.white,
                child:
                    index == 0
                        ? Icon(
                          Icons.calendar_today_outlined,
                          color:
                              isSelected
                                  ? context.colorScheme.primary
                                  : context.colors.grey[900],
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('d').format(state.dateList[index]),
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(
                                    color:
                                        isSelected
                                            ? context.colorScheme.primary
                                            : context.colors.grey[900],
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    fontFamily: FontFamily.roboto,
                                  ),
                            ),
                            Text(
                              DateFormat('E').format(state.dateList[index]),
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(
                                    color:
                                        isSelected
                                            ? context.colorScheme.primary
                                            : context.colors.grey[900],
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    fontFamily: FontFamily.roboto,
                                  ),
                            ),
                          ],
                        ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
