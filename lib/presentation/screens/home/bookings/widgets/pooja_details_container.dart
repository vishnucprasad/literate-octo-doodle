import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/member/member.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PoojaDetailsContainer extends ConsumerWidget {
  const PoojaDetailsContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(expandableContainerControllerProvider.notifier);
    final index = ref.watch(expandableContainerControllerProvider);

    if (index == null) return Placeholder();

    final booking = ref.watch(bookingsControllerProvider).bookings[index];
    final members = [
      Member(name: booking.pooja.name, starSign: booking.pooja.starSign),
      ...booking.pooja.members,
    ];

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
          itemCount: members.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: context.colorScheme.primary,
                  child: Text(
                    members[index].name[0].toUpperCase(),
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    members[index].name,
                    style: context.theme.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Text(
                  members[index].starSign,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
            );
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
