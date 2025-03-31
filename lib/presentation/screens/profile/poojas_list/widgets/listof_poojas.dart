import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';

class ListofPoojas extends StatelessWidget {
  const ListofPoojas({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.colors.primary[50],
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ganapathi Homam',
                          style: context.theme.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppSpacing.verticalSmall,
                        Text(
                          context.l10n.poojaTypeLabel('Homam'),
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: FontFamily.roboto,
                          ),
                        ),
                        AppSpacing.verticalSmall,
                        Text(
                          context.l10n.poojaPriceLabel(1100),
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontFamily: FontFamily.roboto,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.horizontalSmall,
                  Column(
                    children: [
                      Switch(value: true, onChanged: (value) {}),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: context.l10n.statusLabel,
                              style: context.theme.textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontFamily.roboto,
                                  ),
                            ),
                            TextSpan(
                              text: ': ',
                              style: context.theme.textTheme.bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontFamily.roboto,
                                  ),
                            ),
                            TextSpan(
                              text: context.l10n.activeBadgeLabel,
                              style: context.theme.textTheme.bodySmall
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AppSpacing.verticalMedium,
              Row(
                children: [
                  SizedBox(
                    height: 30,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        backgroundColor: context.colors.primary[50],
                        foregroundColor: context.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        side: BorderSide(color: context.colorScheme.primary),
                      ),
                      child: Text(context.l10n.editButtonLabel),
                    ),
                  ),
                  AppSpacing.horizontalSmall,
                  SizedBox(
                    height: 30,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        backgroundColor: context.colors.primary[50],
                        foregroundColor: context.colorScheme.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        side: BorderSide(color: context.colorScheme.error),
                      ),
                      child: Text(context.l10n.deleteButtonLabel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => AppSpacing.verticalMedium,
    );
  }
}
