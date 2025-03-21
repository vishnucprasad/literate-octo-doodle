import 'package:aaraadhya_temple_dashboard/app/router/app_router.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/l10n/app_localizations.dart';
import 'package:aaraadhya_temple_dashboard/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AaraadhyaTempleApp extends ConsumerWidget {
  const AaraadhyaTempleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Aaraadhya Temple',
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
