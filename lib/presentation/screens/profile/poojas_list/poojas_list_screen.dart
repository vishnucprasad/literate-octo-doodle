import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/common/filters/filters_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/poojas_list/widgets/listof_poojas.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/poojas_list/widgets/poojas_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoojasListScreen extends ConsumerWidget {
  const PoojasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(filtersControllerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectIndex(0);
    });

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        AppSpacing.verticalMedium,
        PoojasFilters(),
        AppSpacing.verticalSmall,
        AppInputField(
          hint: context.l10n.searchLabel,
          prefixIcon: Icon(
            Icons.search_outlined,
            color: context.colors.grey[700],
          ),
        ),
        AppSpacing.verticalSmall,
        ListofPoojas(),
        AppSpacing.verticalLarge,
      ],
    );
  }
}
