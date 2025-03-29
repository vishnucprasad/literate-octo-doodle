import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/widgets/event_details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EventDetailsCard extends ConsumerWidget {
  const EventDetailsCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIndex = ref.watch(expandableContainerControllerProvider);
    final controller = ref.read(expandableContainerControllerProvider.notifier);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colors.primary[50],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mahanavami Pooja',
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.verticalSmall,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${context.l10n.eventIdLabel}: ',
                            style: context.theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontVariations: [
                                FontVariation('wght', 700),
                                FontVariation('wdth', 100),
                              ],
                            ),
                          ),
                          TextSpan(
                            text: '1234567890',
                            style: context.theme.textTheme.bodySmall?.copyWith(
                              fontFamily: FontFamily.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.verticalMedium,
                    Text(
                      DateFormat("MMMM d, y • h:mm a").format(DateTime.now()),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.success[50],
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: context.colors.success),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  context.l10n.upcomingEventsLabel,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.colors.success,
                    fontFamily: FontFamily.roboto,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    foregroundColor: context.colorScheme.primary,
                    backgroundColor: context.colors.primary[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    side: BorderSide(
                      color: context.colorScheme.primary,
                      width: 1.0,
                    ),
                  ),
                  child: Text(context.l10n.editButtonLabel),
                ),
              ),
              SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    foregroundColor: context.colorScheme.primary,
                    backgroundColor: context.colors.primary[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    side: BorderSide(
                      color: context.colorScheme.primary,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    context.l10n.registrationsButtonLabel(56),
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.roboto,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: expandedIndex == index ? 0 : 30,
                child: FilledButton(
                  onPressed: () => controller.setIndex(index),
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    foregroundColor: context.colorScheme.primary,
                    backgroundColor: context.colors.primary[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    side: BorderSide(
                      color: context.colorScheme.primary,
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    context.l10n.viewDetailsButtonLabel,
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.roboto,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (expandedIndex == index) EventDetailsContainer(),
        ],
      ),
    );
  }
}
