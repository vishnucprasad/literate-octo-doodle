import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  final String title;
  final Widget? leading;
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
      actionsPadding: EdgeInsets.only(right: 8.0),
      actions:
          actions ??
          [
            IconButton(
              onPressed: () {},
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
