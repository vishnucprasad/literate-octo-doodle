import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/poojas_grid.dart';
import 'package:flutter/material.dart';

class CommonPoojasList extends StatelessWidget {
  const CommonPoojasList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.verticalMedium,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AppInputField(
            hint: context.l10n.searchLabel,
            prefixIcon: Icon(Icons.search),
          ),
        ),
        AppSpacing.verticalMedium,
        Expanded(
          child: ListView(
            children: [PoojasGrid(), AppSpacing.verticalFromPixels(60)],
          ),
        ),
      ],
    );
  }
}
