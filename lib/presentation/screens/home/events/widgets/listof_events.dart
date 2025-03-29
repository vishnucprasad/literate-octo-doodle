import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/filters/filters_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/widgets/event_details_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListofEvents extends ConsumerWidget {
  const ListofEvents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtersIndex = ref.watch(filtersControllerProvider);
    final List<String> filterLabels = [
      context.l10n.allEventsLabel(8),
      context.l10n.upcomingEventsLabel,
      context.l10n.previousEventsLabel,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            context.l10n.eventsSectionTitle(filterLabels[filtersIndex]),
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: context.colors.grey[900],
              fontFamily: FontFamily.roboto,
              fontVariations: [FontVariation('wght', 400)],
            ),
          ),
        ),
        AppSpacing.verticalMedium,
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return EventDetailsCard(index: index);
          },
          separatorBuilder: (context, index) => AppSpacing.verticalMedium,
        ),
      ],
    );
  }
}
