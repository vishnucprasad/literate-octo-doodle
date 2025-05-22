import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/date_list/date_list_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/booking_details_card.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/bookings_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ListofBookings extends ConsumerWidget {
  const ListofBookings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(
      dateListControllerProvider.select((state) => state.selectedDate),
    );

    final state = ref.watch(bookingsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            context.l10n.bookingsSectionTitle(
              DateFormat('MMMM').format(selectedDate),
              DateFormat('d').format(selectedDate),
            ),
            style: context.theme.textTheme.titleLarge?.copyWith(
              color: context.colors.grey[900],
              fontFamily: FontFamily.roboto,
              fontVariations: [FontVariation('wght', 400)],
            ),
          ),
        ),
        AppSpacing.verticalMedium,
        state.isLoading
            ? BookingsLoadingShimmer()
            : state.bookings.isEmpty
            ? SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block_outlined,
                    size: 72,
                    color: context.colors.grey[700],
                  ),
                  AppSpacing.verticalMedium,
                  Text(
                    context.l10n.noBookingsFound,
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      color: context.colors.grey[900],
                      fontFamily: FontFamily.roboto,
                      fontVariations: [FontVariation('wght', 400)],
                    ),
                  ),
                ],
              ),
            )
            : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                return BookingDetailsCard(index: index);
              },
              separatorBuilder: (context, index) => AppSpacing.verticalMedium,
            ),
      ],
    );
  }
}
