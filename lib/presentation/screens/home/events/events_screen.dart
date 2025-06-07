import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/feature_coming_soon.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.eventsManagementAppBarTitle),
          Expanded(
            child: FeatureComingSoon(
              title: context.l10n.eventsComingSoonTitle,
              message: context.l10n.eventsComingSoonMessage,
              icon: Icons.event_available,
            ),
          ),
          // Expanded(
          //   child: ListView(
          //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //     children: [
          //       EventsFilters(),
          //       AppSpacing.verticalMedium,
          //       ListofEvents(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
