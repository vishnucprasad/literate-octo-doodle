import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' hide TextDirection;

class DateSelector extends HookConsumerWidget {
  const DateSelector({
    super.key,
    required this.dateList,
    required this.selectedDateIndex,
    required this.selectDate,
    this.invert = false,
  });

  final List<DateTime> dateList;
  final int selectedDateIndex;
  final void Function({required int index, DateTime? date}) selectDate;
  final bool invert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useEffect(() {
      if (invert) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }

      return null;
    }, const []);

    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: context.colors.grey[50],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
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
                      headerHeadlineStyle: context.theme.textTheme.headlineLarge
                          ?.copyWith(fontFamily: FontFamily.roboto),
                      headerHelpStyle: context.theme.textTheme.bodyMedium
                          ?.copyWith(fontFamily: FontFamily.roboto),
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

              return selectDate(index: 0, date: date);
            },
            style: IconButton.styleFrom(
              overlayColor: context.colorScheme.primary,
            ),
            icon: CircleAvatar(
              radius: selectedDateIndex == 0 ? 26 : 22,
              backgroundColor:
                  selectedDateIndex == 0
                      ? context.colors.primary[50]
                      : Colors.white,
              child: Icon(
                Icons.calendar_today_outlined,
                color:
                    selectedDateIndex == 0
                        ? context.colorScheme.primary
                        : context.colors.grey[900],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: invert ? TextDirection.rtl : TextDirection.ltr,
                children: List.generate(dateList.length, (index) {
                  bool isSelected = selectedDateIndex == index;
                  if (index == 0) {
                    return SizedBox.shrink();
                  } else {
                    return IconButton(
                      onPressed: () => selectDate(index: index),
                      style: IconButton.styleFrom(
                        overlayColor: context.colorScheme.primary,
                      ),
                      icon: CircleAvatar(
                        radius: isSelected ? 26 : 22,
                        backgroundColor:
                            isSelected
                                ? context.colors.primary[50]
                                : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('d').format(dateList[index]),
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
                              DateFormat('E').format(dateList[index]),
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
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
