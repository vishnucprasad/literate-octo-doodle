import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/pooja_schedules_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeleteScheduleConfirmationDialog extends ConsumerWidget {
  const DeleteScheduleConfirmationDialog({super.key, required this.scheduleId});

  final String scheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poojaSchedulesControllerProvider);
    final controller = ref.read(poojaSchedulesControllerProvider.notifier);

    ref.listen(
      poojaSchedulesControllerProvider.select((state) => state.isDeleting),
      (previous, next) {
        if (previous == true && !next) {
          context.pop();
        }
      },
    );

    return AlertDialog(
      icon: CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child:
            state.isDeleting
                ? SizedBox.square(
                  dimension: 24.0,
                  child: CircularProgressIndicator(
                    color: context.colorScheme.onPrimary,
                  ),
                )
                : Icon(Icons.question_mark, color: context.colors.white),
      ),
      iconPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      title: Text(
        context.l10n.deleteScheduleConfirmationDialogTitle,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
      content: Text(
        context.l10n.deleteScheduleConfirmationDialogDescription,
        textAlign: TextAlign.center,
      ),
      actionsPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(foregroundColor: context.colors.error),
          child: Text(context.l10n.cancelButtonLabel),
        ),
        TextButton(
          onPressed: () async {
            await controller.deleteSchedule(scheduleId);
          },
          child: Text(context.l10n.deleteButtonLabel),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    );
  }
}
