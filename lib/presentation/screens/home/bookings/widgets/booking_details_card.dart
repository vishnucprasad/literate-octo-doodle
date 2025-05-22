import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/pooja_details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingDetailsCard extends ConsumerWidget {
  const BookingDetailsCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIndex = ref.watch(expandableContainerControllerProvider);
    final controller = ref.read(expandableContainerControllerProvider.notifier);

    final booking = ref.watch(bookingsControllerProvider).bookings[index];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: context.colors.primary[50],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      visualDensity: VisualDensity.compact,
                      onChanged: (value) {},
                      side: BorderSide(color: context.colorScheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    AppSpacing.horizontalSmall,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.pooja.schedule.pooja.name,
                            style: context.theme.textTheme.titleSmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSpacing.verticalSmall,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${context.l10n.bookingIdLabel}: ',
                                  style: context.theme.textTheme.bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontVariations: [
                                          FontVariation('wght', 700),
                                          FontVariation('wdth', 100),
                                        ],
                                      ),
                                ),
                                TextSpan(
                                  text: booking.id,
                                  style: context.theme.textTheme.bodySmall
                                      ?.copyWith(fontFamily: FontFamily.roboto),
                                ),
                              ],
                            ),
                          ),
                          AppSpacing.verticalSmall,
                          Text(
                            context.l10n.membersCount(
                              booking.pooja.members.length + 1,
                            ),
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              fontFamily: FontFamily.roboto,
                            ),
                          ),
                          AppSpacing.verticalMedium,
                          Text(
                            DateFormat(
                              "MMMM d, y",
                            ).format(DateTime.parse(booking.pooja.poojaDate)),
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              fontFamily: FontFamily.roboto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppSpacing.verticalSmall,
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: context.colors.success,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    child: Text(
                      context.l10n.confirmedBadgeLabel,
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        color: context.colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  if (expandedIndex != index)
                    SizedBox(
                      height: 26,
                      child: FilledButton(
                        onPressed: () => controller.setIndex(index),
                        style: FilledButton.styleFrom(
                          textStyle: context.theme.textTheme.bodyMedium
                              ?.copyWith(
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
                        child: Text(context.l10n.viewDetailsButtonLabel),
                      ),
                    ),
                ],
              ),
            ],
          ),
          if (expandedIndex == index) PoojaDetailsContainer(),
        ],
      ),
    );
  }
}
