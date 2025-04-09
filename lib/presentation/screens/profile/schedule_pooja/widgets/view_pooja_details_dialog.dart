import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/pooja_schedules_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/schedule_pooja_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewPoojaDetailsDialog extends ConsumerWidget {
  const ViewPoojaDetailsDialog({required this.pooja, super.key});

  final Pooja pooja;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(poojaSchedulesControllerProvider.notifier);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(pooja.imageUrl),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pooja.name,
                            style: context.theme.textTheme.headlineSmall
                                ?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AppSpacing.verticalMedium,
                          Text(
                            pooja.description,
                            style: context.theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: FilledButton(
                  onPressed: () {
                    controller.selectPoojaForSchedule(pooja);
                    context.pop();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SchedulePoojaForm(),
                    );
                  },
                  child: Text(context.l10n.scheduleNowButtonLabel),
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.close, color: context.colorScheme.onSurface),
              style: IconButton.styleFrom(
                backgroundColor: context.colorScheme.surface,
              ),
              onPressed: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
