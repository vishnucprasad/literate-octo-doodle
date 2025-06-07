import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/account_settings.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/booking_settings.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/widgets/notification_setttings.dart';
import 'package:flutter/material.dart';

class AdvancedDetailsScreen extends StatelessWidget {
  const AdvancedDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        AppSpacing.verticalMedium,
        NotificationSetttings(),
        AppSpacing.verticalMedium,
        BookingSettings(),
        AppSpacing.verticalMedium,
        AccountSettings(),
        AppSpacing.verticalLarge,
      ],
    );
  }
}
