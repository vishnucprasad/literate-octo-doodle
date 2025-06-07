import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.title,
    this.leading,
    this.bottom,
    this.actions,
  });

  final String title;
  final Widget? leading;
  final Widget? bottom;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      leading:
          context.canPop()
              ? Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 8.0),
                child: AppBackButton(),
              )
              : leading,
      title: Text(
        title,
        style: context.theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom:
          bottom != null
              ? PreferredSize(
                preferredSize: Size.fromHeight(46.0),
                child: bottom!,
              )
              : null,
      actionsPadding: EdgeInsets.only(right: 8.0),
      actions:
          actions ??
          [
            IconButton(
              onPressed: () {
                context.push(AppRoutes.notifications.path);
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            IconButton(
              onPressed: () {
                context.push(AppRoutes.profileSettingsScreen.path);
              },
              icon: CircleAvatar(
                backgroundColor: context.theme.colorScheme.primary,
                child: Icon(
                  Icons.person,
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
    );
  }
}
