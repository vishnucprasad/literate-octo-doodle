import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/contact_details/contact_details_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/advanced_detaiils/advanced_details_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/basic_details/basic_details_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/contact_details/contact_details_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/gallery/gallery_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/poojas_list/poojas_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileSettingsScreen extends HookConsumerWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndexNotifier = useState<int>(0);
    final tabController = useTabController(
      initialLength: 5,
      initialIndex: currentIndexNotifier.value,
    );

    useEffect(() {
      tabController.addListener(() {
        if (!tabController.indexIsChanging) {
          currentIndexNotifier.value = tabController.index;
        }
      });

      return tabController.dispose;
    }, []);

    final basicDetailsState = ref.watch(basicDetailsControllerProvider);
    final basicDetailsController = ref.read(
      basicDetailsControllerProvider.notifier,
    );
    final contactDetailsState = ref.watch(contactDetailsControllerProvider);
    final contactDetailsController = ref.read(
      contactDetailsControllerProvider.notifier,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: HomeAppBar(
          title: context.l10n.profileSettingsAppBarTitle,
          bottom: TabBar(
            controller: tabController,
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
          actions: [
            if (currentIndexNotifier.value == 0 &&
                !basicDetailsState.isFormEnabled) ...[
              SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: basicDetailsController.enableForm,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  child: Text(context.l10n.editButtonLabel),
                ),
              ),
            ],
            if (currentIndexNotifier.value == 3 &&
                !contactDetailsState.isFormEnabled) ...[
              SizedBox(
                height: 30,
                child: FilledButton(
                  onPressed: contactDetailsController.enableForm,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  child: Text(context.l10n.editButtonLabel),
                ),
              ),
            ],
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          BasicDetailsScreen(),
          PoojasListScreen(),
          GalleryScreen(),
          ContactDetailsScreen(),
          AdvancedDetailsScreen(),
        ],
      ),
    );
  }
}
