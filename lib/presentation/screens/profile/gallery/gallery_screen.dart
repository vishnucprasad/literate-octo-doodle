import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/widgets/gallery_action_buttons.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/widgets/gallery_grid_view.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpacing.verticalMedium,
        Expanded(child: GalleryGridView()),
        AppSpacing.verticalMedium,
        GalleryActionButtons(),
      ],
    );
  }
}
