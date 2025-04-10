import 'package:aaraadhya_temple_dashboard/core/enums/pooja_time.dart';
import 'package:aaraadhya_temple_dashboard/core/enums/schedule_mode.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PoojaItem extends StatelessWidget {
  const PoojaItem({super.key, required this.schedule});

  final PoojaSchedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colors.primary[50],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.pooja.name,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.verticalSmall,
                    Text(
                      context.l10n.poojaModeLabel(
                        schedule.scheduleMode?.getName(context) ?? '',
                      ),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                    AppSpacing.verticalSmall,
                    if (schedule.scheduleMode == ScheduleMode.repeat) ...[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context.l10n.poojaDaysLabel,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                            TextSpan(
                              text: ': ',
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                            TextSpan(
                              text:
                                  schedule.poojaDays
                                      ?.asMap()
                                      .entries
                                      .map((e) {
                                        if (e.value) {
                                          return [
                                            'Sun',
                                            'Mon',
                                            'Tue',
                                            'Wed',
                                            'Thu',
                                            'Fri',
                                            'Sat',
                                          ][e.key];
                                        }
                                      })
                                      .where((e) => e != null)
                                      .toList()
                                      .join(', ') ??
                                  '',
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.verticalSmall,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context.l10n.poojaTimeLabel,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                            TextSpan(
                              text: ': ',
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                            TextSpan(
                              text: schedule.poojaTime?.getName(context),
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.verticalSmall,
                    ],
                    if (schedule.scheduleMode == ScheduleMode.once) ...[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context.l10n.poojaTimeLabel,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                            TextSpan(
                              text: ': ',
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                            TextSpan(
                              text: DateFormat("MMMM d, y • h:mm a").format(
                                schedule.poojaDateAndTime ?? DateTime.now(),
                              ),
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.verticalSmall,
                    ],
                    Text(
                      context.l10n.poojaPriceLabel(schedule.price),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSmall,
              Column(
                children: [
                  Switch(
                    inactiveTrackColor: context.colors.grey,
                    activeTrackColor: context.colors.primary,
                    inactiveThumbColor: context.colors.grey[700],
                    value: schedule.isActive,
                    onChanged: (value) {},
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context.l10n.statusLabel,
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.roboto,
                          ),
                        ),
                        TextSpan(
                          text: ': ',
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.roboto,
                          ),
                        ),
                        TextSpan(
                          text:
                              schedule.isActive
                                  ? context.l10n.activeBadgeLabel
                                  : context.l10n.inactiveBadgeLabel,
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            fontFamily: FontFamily.roboto,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppSpacing.verticalMedium,
          Row(
            children: [
              SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    backgroundColor: context.colors.primary[50],
                    foregroundColor: context.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    side: BorderSide(color: context.colorScheme.primary),
                  ),
                  child: Text(context.l10n.editButtonLabel),
                ),
              ),
              AppSpacing.horizontalSmall,
              SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    backgroundColor: context.colors.primary[50],
                    foregroundColor: context.colorScheme.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    side: BorderSide(color: context.colorScheme.error),
                  ),
                  child: Text(context.l10n.deleteButtonLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
