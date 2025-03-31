import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.text,
    required this.trailing,
    this.onTap,
  });

  final String text;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: context.colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      title: Text(text),
      trailing: trailing,
    );
  }
}
