import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventDetailsContainer extends ConsumerWidget {
  const EventDetailsContainer({super.key});

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
          context.l10n.eventDetailsSectionTitle,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.eventIdLabel),
        AppSpacing.verticalSmall,
        Text(
          "1234567890",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.eventTypeLabel),
        AppSpacing.verticalSmall,
        Text(
          "Special pooja",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.eventDateAndTimeLabel),
        AppSpacing.verticalSmall,
        Text(
          DateFormat("MMMM d, y • h:mm a").format(DateTime.now()),
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.eventDescriptionLabel),
        AppSpacing.verticalSmall,
        Text(
          "Special pooja will taking place inside the temple. Those who want participate in this pooja can register through the  REGISTER button below",
          style: context.theme.textTheme.bodyMedium,
        ),
        AppSpacing.verticalMedium,
        Row(
          children: [
            Text(context.l10n.statusLabel),
            AppSpacing.horizontalSmall,
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: context.colors.success,
                borderRadius: BorderRadius.circular(14.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(
                context.l10n.activeBadgeLabel,
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: context.colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.roboto,
                ),
              ),
            ),
          ],
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.eventLocationLabel),
        AppSpacing.verticalSmall,
        Text(
          "Main Temple",
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Text(context.l10n.eventRegistrationsCountLabel),
        AppSpacing.verticalSmall,
        Text(
          context.l10n.registrationsCount(43),
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.roboto,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalMedium,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 30,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  foregroundColor: context.colors.white,
                  backgroundColor: context.colors.success,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                child: Text(context.l10n.viewRegistrationsButtonLabel),
              ),
            ),
            SizedBox(
              height: 30,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
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
                  context.l10n.editButtonLabel,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.roboto,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: FilledButton(
                onPressed: () => controller.setIndex(null),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
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
                  context.l10n.hideDetailsButtonLabel,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.roboto,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
