import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/di/providers.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNameAndVersionInfo extends ConsumerWidget {
  const AppNameAndVersionInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.appName,
          style: context.theme.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.verticalSmall,
        FutureBuilder(
          future: ref.read(packageInfoProvider.future),
          builder: (context, snapshot) {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${context.l10n.versionLabel} : ',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: snapshot.data?.version ?? '',
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.roboto,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
