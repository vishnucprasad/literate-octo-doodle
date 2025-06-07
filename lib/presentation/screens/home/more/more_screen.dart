import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/more/widgets/app_name_and_version_info.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/more/widgets/menu_list.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          HomeAppBar(title: context.l10n.moreOptionsAppBarTitle),
          Spacer(),
          AppNameAndVersionInfo(),
          Spacer(),
          MenuList(),
        ],
      ),
    );
  }
}
