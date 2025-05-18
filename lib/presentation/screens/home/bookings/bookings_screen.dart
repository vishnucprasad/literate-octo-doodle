import 'dart:developer';

import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_respository.dart';
import 'package:aaraadhya_temple_dashboard/di/firebase_providers.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/date_selector.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/date_list/date_list_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/bookings_filters.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/widgets/listof_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingsScreen extends ConsumerWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final userId = ref.watch(authProvider).currentUser?.uid;
      final date = ref.watch(dateListControllerProvider).selectedDate;
      if (userId != null)
        ref
            .read(bookingRespositoryProvider)
            .getAllBookings(userId, date)
            .then((bookings) => log(bookings.toString(), name: 'BOOKING DATA'));
    });

    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.bookingsManagementAppBarTitle),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                DateSelector(),
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
