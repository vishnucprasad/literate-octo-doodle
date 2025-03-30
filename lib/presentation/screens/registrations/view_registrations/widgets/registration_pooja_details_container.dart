import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/registrations/view_registrations/widgets/registration_individual_pooja_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegistrationPoojaDetailsContainer extends ConsumerWidget {
  const RegistrationPoojaDetailsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(expandableContainerControllerProvider.notifier);
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      children: [
        AppSpacing.verticalSmall,
        Divider(color: context.colorScheme.primary),
        AppSpacing.verticalSmall,
        Text(
          context.l10n.poojaDetailsSectionTitle,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalSmall,
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return RegistrationIndividualPoojaListTile();
          },
          separatorBuilder: (context, index) => AppSpacing.verticalSmall,
        ),
        AppSpacing.verticalSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 24,
              child: FilledButton(
                onPressed: () => controller.setIndex(null),
                style: FilledButton.styleFrom(
                  textStyle: context.theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.roboto,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  backgroundColor: context.colors.primary[50],
                  foregroundColor: context.colorScheme.primary,
                  side: BorderSide(
                    width: 1,
                    color: context.colorScheme.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Text(context.l10n.hideDetailsButtonLabel),
              ),
            ),
            AppSpacing.horizontalSmall,
          ],
        ),
      ],
    );
  }
}
