import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/common/filters/filters_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoojasFilters extends ConsumerWidget {
  const PoojasFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(filtersControllerProvider);
    final controller = ref.read(filtersControllerProvider.notifier);

    final List<String> filters = [
      context.l10n.allPoojasCountLabel(8),
      context.l10n.activeBadgeLabel,
      context.l10n.inactiveBadgeLabel,
    ];

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.selectIndex(0);
        }
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(filters.length, (index) {
            final isSelected = selectedIndex == index;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: FilledButton(
                onPressed: () => controller.selectIndex(index),
                style: FilledButton.styleFrom(
                  backgroundColor:
                      isSelected
                          ? context.colors.primary[50]
                          : context.colors.grey[100],
                  foregroundColor:
                      isSelected
                          ? context.colors.primary
                          : context.colors.grey[900],
                  textStyle:
                      isSelected
                          ? context.theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.roboto,
                          )
                          : context.theme.textTheme.bodyLarge?.copyWith(
                            fontFamily: FontFamily.roboto,
                          ),
                ),
                child: Text(filters[index]),
              ),
            );
          }),
        ),
      ),
    );
  }
}
