import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RepeatDaysPicker extends HookWidget {
  final List<bool>? initialSelected;
  final void Function(List<bool>)? onChanged;
  final String? labelText;
  final String? errorText;

  const RepeatDaysPicker({
    super.key,
    this.initialSelected,
    this.onChanged,
    this.labelText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDays = useState<List<bool>>(
      List.from(initialSelected ?? List<bool>.filled(7, false)),
    );

    final List<String> daysShort = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final List<String> daysFull = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];

    void toggleDay(int index) {
      final updated = [...selectedDays.value];
      updated[index] = !updated[index];
      selectedDays.value = updated;
      onChanged?.call(updated);
    }

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
        Wrap(
          spacing: 8,
          children: List.generate(7, (index) {
            final isSelected = selectedDays.value[index];
            return ChoiceChip(
              label: Text(
                daysShort[index],
                style: TextStyle(
                  color:
                      isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => toggleDay(index),
              tooltip: daysFull[index],
              selectedColor: context.colorScheme.primary,
              backgroundColor: context.colorScheme.outline,
              side: BorderSide.none,
              showCheckmark: false,
            );
          }),
        ),
        if (errorText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              errorText!,
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
