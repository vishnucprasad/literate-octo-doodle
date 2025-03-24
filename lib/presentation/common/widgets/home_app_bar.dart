import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      title: Text(
        title,
        style: context.theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actionsPadding: EdgeInsets.only(right: 8.0),
      actions: [
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
