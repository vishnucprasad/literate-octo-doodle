import 'package:aaraadhya_temple_dashboard/core/gen/l10n/app_localizations.dart';
import 'package:aaraadhya_temple_dashboard/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AaraadhyaTempleApp extends StatelessWidget {
  const AaraadhyaTempleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aaraadhya Temple',
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: Center(child: Text('Aaraadhya Temple'))),
    );
  }
}
