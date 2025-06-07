import 'package:aaraadhya_temple_dashboard/core/enums/pooja_type.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/poojas_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SpecialPoojasList extends HookWidget {
  const SpecialPoojasList({super.key});

  @override
  Widget build(BuildContext context) {
    final searchQuery = useState<String?>(null);

    return Column(
      children: [
        AppSpacing.verticalMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppInputField(
            hint: context.l10n.searchLabel,
            prefixIcon: Icon(Icons.search),
            onChanged: (query) {
              searchQuery.value = query;
            },
          ),
        ),
        AppSpacing.verticalMedium,
        Expanded(
          child: ListView(
            children: [
              PoojasGrid(
                poojaType: PoojaType.specialPooja,
                searchquery: searchQuery.value,
              ),
              AppSpacing.verticalFromPixels(60),
            ],
          ),
        ),
      ],
    );
  }
}
