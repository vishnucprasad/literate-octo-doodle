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
              onPressed: () => controller.selectIndex(index),
              style: IconButton.styleFrom(
                overlayColor: context.colorScheme.primary,
              ),
              icon: CircleAvatar(
                radius: isSelected ? 26 : 22,
                backgroundColor:
                    isSelected ? context.colors.primary[50] : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('d').format(state.dateList[index]),
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color:
                            isSelected
                                ? context.colorScheme.primary
                                : context.colors.grey[900],
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                    Text(
                      DateFormat('E').format(state.dateList[index]),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color:
                            isSelected
                                ? context.colorScheme.primary
                                : context.colors.grey[900],
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
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
