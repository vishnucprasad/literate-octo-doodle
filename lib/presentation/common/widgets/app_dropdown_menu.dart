import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

class AppDropdownMenu<T> extends StatelessWidget {
  const AppDropdownMenu({
    super.key,
    this.hint,
    this.labelText,
    this.filled,
    this.fillColor,
    this.menuBackgroundColor,
    this.textStyle,
    required this.items,
    required this.onSelected,
  });

  final String? hint;
  final String? labelText;
  final bool? filled;
  final Color? fillColor;
  final Color? menuBackgroundColor;
  final TextStyle? textStyle;
  final List<DropdownMenuEntry<T>> items;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
            DropdownMenu<T>(
              width: constraints.maxWidth,
              hintText: hint,
              inputDecorationTheme: InputDecorationTheme(
                filled: filled ?? true,
                fillColor: fillColor ?? context.colors.grey[50],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              alignmentOffset: Offset(0, 8.0),
              menuStyle: MenuStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.zero),
                maximumSize: WidgetStateProperty.all(
                  Size(constraints.maxWidth, double.infinity),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  menuBackgroundColor ?? context.colors.grey[50],
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
              textStyle: textStyle ?? context.theme.textTheme.bodyMedium,
              dropdownMenuEntries: List.generate(items.length, (index) {
                return DropdownMenuEntry<T>(
                  style: FilledButton.styleFrom(
                    overlayColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    textStyle: context.theme.textTheme.bodyMedium?.copyWith(
                      color: context.colors.grey[700],
                    ),
                  ),
                  value: items[index].value,
                  label: items[index].label,
                );
              }),
              onSelected: onSelected,
            ),
          ],
        );
      },
    );
  }
}
