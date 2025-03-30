import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/basic_details_action_buttons.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/basic_details_form.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/widgets/profile_picture_container.dart';
import 'package:flutter/material.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';

class BasicDetailsScreen extends StatelessWidget {
  const BasicDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            AppSpacing.verticalMedium,
            ProfilePictureContainer(),
            AppSpacing.verticalMedium,
            BasicDetailsForm(),
            SizedBox(height: 100.0),
          ],
        ),
        BasicDetailsActionButtons(),
      ],
    );
  }
}
