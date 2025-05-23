import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/common/filters/filters_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingsFilters extends ConsumerWidget {
  const BookingsFilters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(filtersControllerProvider);
    final controller = ref.read(filtersControllerProvider.notifier);
    final bookingController = ref.read(bookingsControllerProvider.notifier);

    final List<String> filters = [
      context.l10n.allBoookingsLabel,
      context.l10n.confirmedBadgeLabel,
      context.l10n.completedBadgeLabel,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FilledButton(
              onPressed: () {
                controller.selectIndex(index);
                switch (index) {
                  case 0:
                    bookingController.changeFilter(null);
                    break;
                  case 1:
                    bookingController.changeFilter(BookingStatus.confirmed);
                    break;
                  case 2:
                    bookingController.changeFilter(BookingStatus.completed);
                    break;
                  default:
                    bookingController.changeFilter(null);
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor:
                    isSelected
                        ? context.colors.primary[50]
                        : context.colors.grey[100],
                foregroundColor:
                    isSelected
                        ? context.colors.primary
                        : context.colors.grey[900],
                textStyle:
                    isSelected
                        ? context.theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.roboto,
                        )
                        : context.theme.textTheme.bodyLarge?.copyWith(
                          fontFamily: FontFamily.roboto,
                        ),
              ),
              child: Text(filters[index]),
            ),
          );
        }),
      ),
    );
  }
}
