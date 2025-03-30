import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/widgets/events_filters.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/widgets/listof_events.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(title: context.l10n.eventsManagementAppBarTitle),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              EventsFilters(),
              AppSpacing.verticalMedium,
              ListofEvents(),
            ],
          ),
        ),
      ],
    );
  }
}
