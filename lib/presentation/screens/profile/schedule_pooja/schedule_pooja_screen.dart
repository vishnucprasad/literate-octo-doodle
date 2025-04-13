import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/common_poojas_list.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/add_pooja_form.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/special_poojas_list.dart';
import 'package:flutter/material.dart';

class SchedulePoojaScreen extends StatelessWidget {
  const SchedulePoojaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(102),
          child: HomeAppBar(
            title: context.l10n.schedulePoojaAppBarTitle,
            bottom: TabBar(
              enableFeedback: true,
              dividerHeight: 0.5,
              dividerColor: context.colors.grey,
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
                Tab(text: context.l10n.commonPoojasLabel),
                Tab(text: context.l10n.specialPoojasLabel),
              ],
            ),
            actions: [],
          ),
        ),
        body: TabBarView(children: [CommonPoojasList(), SpecialPoojasList()]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FilledButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddPoojaForm(),
            );
          },
          child: Text(context.l10n.addNewPoojaButtonLabel),
        ),
      ),
    );
  }
}
