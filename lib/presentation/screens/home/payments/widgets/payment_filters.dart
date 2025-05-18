import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/common/filters/filters_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentFilters extends ConsumerWidget {
  const PaymentFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(filtersControllerProvider);
    final controller = ref.read(filtersControllerProvider.notifier);

    final List<String> filters = [
      context.l10n.allPaymentsLabelWithCount(2),
      context.l10n.approvedBadgeLabel,
      context.l10n.rejectedBadgeLabel,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
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
    );
  }
}
