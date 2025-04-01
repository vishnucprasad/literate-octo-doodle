import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_media_query_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_dropdown_menu.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PoojaForm extends StatelessWidget {
  const PoojaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.3,
      expand: false,
      maxChildSize: 0.88,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.mediaQuery.viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: context.width / 4,
                      height: 5,
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  AppSpacing.verticalLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.addNewPoojaFormTitle,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            context.l10n.activeBadgeLabel,
                            style: context.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSpacing.horizontalSmall,
                          SizedBox(
                            width: 40,
                            child: Transform.scale(
                              scale: 0.75,
                              child: Switch(
                                value: true,
                                onChanged: (value) {},
                                padding: EdgeInsets.zero,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.poojaNameHintText,
                    labelText: context.l10n.poojaNameLabel,
                    prefixIcon: Icon(
                      Icons.temple_hindu_outlined,
                      color: context.colors.grey[700],
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.poojaPriceHintText,
                    labelText: context.l10n.pricelabel,
                    prefixIcon: Icon(
                      Icons.currency_rupee_sharp,
                      color: context.colors.grey[700],
                    ),
                  ),
                  AppSpacing.verticalMedium,
                  AppDropdownMenu<String>(
                    hint: context.l10n.chooseOneLabel,
                    labelText: context.l10n.poojaTypeLabelText,
                    items: [
                      DropdownMenuEntry<String>(
                        value: context.l10n.homamLabel,
                        label: context.l10n.homamLabel,
                      ),
                      DropdownMenuEntry<String>(
                        value: context.l10n.archanaLabel,
                        label: context.l10n.archanaLabel,
                      ),
                      DropdownMenuEntry<String>(
                        value: context.l10n.specialPoojaLabel,
                        label: context.l10n.specialPoojaLabel,
                      ),
                      DropdownMenuEntry<String>(
                        value: context.l10n.othersLabel,
                        label: context.l10n.othersLabel,
                      ),
                    ],
                    onSelected: (value) {},
                  ),
                  AppSpacing.verticalMedium,
                  AppInputField(
                    hint: context.l10n.poojaDescriptionHintText,
                    labelText: context.l10n.poojaDescriptionLabel,
                    maxLines: 5,
                  ),
                  AppSpacing.verticalMedium,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: context.colors.error,
                            side: BorderSide(
                              color: context.colors.error,
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.cancelButtonLabel),
                        ),
                      ),
                      AppSpacing.horizontalSmall,
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                          ),
                          child: Text(context.l10n.saveButtonLabel),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
