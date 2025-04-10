import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/common/filters/filters_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/pooja_schedules_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/poojas_list/widgets/pooja_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListofPoojas extends ConsumerWidget {
  const ListofPoojas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poojaSchedulesControllerProvider);
    final filter = ref.watch(filtersControllerProvider);

    final schedulesList =
        state.schedules
            .where(
              (schedule) =>
                  filter == 0
                      ? true
                      : filter == 1
                      ? schedule.isActive
                      : !schedule.isActive,
            )
            .toList();

    return state.isLoading
        ? ShimmerLoader(
          isLoading: state.isLoading,
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return PoojaItem(schedule: PoojaSchedule.empty());
            },
            separatorBuilder: (context, index) => AppSpacing.verticalMedium,
          ),
        )
        : ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: schedulesList.length,
          itemBuilder: (context, index) {
            return PoojaItem(schedule: schedulesList[index]);
          },
          separatorBuilder: (context, index) => AppSpacing.verticalMedium,
        );
  }
}
