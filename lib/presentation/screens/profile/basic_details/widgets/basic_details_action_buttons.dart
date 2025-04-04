import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BasicDetailsActionButtons extends ConsumerWidget {
  const BasicDetailsActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(basicDetailsControllerProvider);
    final controller = ref.read(basicDetailsControllerProvider.notifier);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: Border(
            top: BorderSide(color: context.colors.grey, width: 0.5),
          ),
        ),
        child: Column(
          children: [
            if (state.isSaving) ...[
              LinearProgressIndicator(
                backgroundColor: context.colorScheme.surface,
              ),
            ],
            AppSpacing.verticalMedium,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.colors.error,
                      side: BorderSide(color: context.colors.error, width: 1.0),
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
                    onPressed: controller.saveChanges,
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
    );
  }
}
