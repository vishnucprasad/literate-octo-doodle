import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/advanced_details_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/basic_details_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/contact_details/contact_details_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/gallery_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/poojas_list/poojas_list_screen.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(102),
          child: HomeAppBar(
            title: context.l10n.profileSettingsAppBarTitle,
            bottom: TabBar(
              enableFeedback: true,
              dividerHeight: 0.5,
              dividerColor: context.colors.grey,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
              labelColor: context.colors.primary,
              labelStyle: context.theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: context.colors.grey[700],
              unselectedLabelStyle: context.theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: context.l10n.basicTabLabel),
                Tab(text: context.l10n.poojasTabLabel),
                Tab(text: context.l10n.galleryTabLabel),
                Tab(text: context.l10n.contactTabLabel),
                Tab(text: context.l10n.advancedTabLabel),
              ],
            ),
            actions: [],
          ),
        ),
        body: TabBarView(
          children: [
            BasicDetailsScreen(),
            PoojasListScreen(),
            GalleryScreen(),
            ContactDetailsScreen(),
            AdvancedDetailsScreen(),
          ],
        ),
      ),
    );
  }
}
