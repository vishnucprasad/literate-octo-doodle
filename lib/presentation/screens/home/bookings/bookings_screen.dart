import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_snack_bar_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/date_selector.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/bookings_filters.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/listof_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(bookingsControllerProvider, (previous, next) {
      final error = next.error;

      if (previous?.error != next.error) {
        if (error is DatabaseException) {
          context.showErrorSnackbar(
            message: error.getDatabaseExceptionMessage(context),
          );
        }
      }
    });

    final state = ref.watch(bookingsControllerProvider);
    final controller = ref.read(bookingsControllerProvider.notifier);

    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.bookingsManagementAppBarTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                DateSelector(
                  dateList: state.dateList,
                  selectedDateIndex: state.selectedDateIndex,
                  selectDate: controller.selectDate,
                ),
                AppSpacing.verticalMedium,
                BookingsFilters(),
                AppSpacing.verticalMedium,
                ListofBookings(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
