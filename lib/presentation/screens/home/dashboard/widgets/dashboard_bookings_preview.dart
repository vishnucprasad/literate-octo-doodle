import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/dashboard/dashboard_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/widgets/dash_board_bookings_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardBookingsPreview extends ConsumerWidget {
  const DashboardBookingsPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.todaysBookingsSectionTitle,
                style: context.theme.textTheme.titleLarge,
              ),
              SizedBox(
                height: 30.0,
                child: FilledButton(
                  onPressed: () => context.go(AppRoutes.bookings.path),
                  style: FilledButton.styleFrom(
                    backgroundColor: context.colors.primary[50],
                    foregroundColor: context.colorScheme.primary,
                  ),
                  child: Text(context.l10n.viewAllButtonLabel),
                ),
              ),
            ],
          ),
        ),
        AppSpacing.verticalMedium,
        state.isLoading
            ? DashBoardBookingsLoadingShimmer()
            : state.data.latestBookings.isEmpty
            ? Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.primary[50],
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Column(
                children: [
                  AppSpacing.verticalSmall,
                  Icon(Icons.block),
                  AppSpacing.verticalSmall,
                  Text(context.l10n.noBookingsFound),
                  AppSpacing.verticalSmall,
                ],
              ),
            )
            : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.data.latestBookings.length,
              itemBuilder: (context, index) {
                final booking = state.data.latestBookings[index];

                return Container(
                  decoration: BoxDecoration(
                    color: context.colors.grey[50],
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: context.colorScheme.primary,
                      child: Text(
                        booking.pooja.name[0].toUpperCase(),
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        booking.pooja.name,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      booking.pooja.schedule.pooja.name,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.colors.grey[900],
                        fontFamily: FontFamily.roboto,
                      ),
                    ),
                    trailing: Text(
                      context.l10n.membersCount(
                        booking.pooja.members.length + 1,
                      ),
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: FontFamily.roboto,
                        fontVariations: [
                          FontVariation('wght', 400),
                          FontVariation('wdth', 100),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return AppSpacing.verticalSmall;
              },
            ),
      ],
    );
  }
}
