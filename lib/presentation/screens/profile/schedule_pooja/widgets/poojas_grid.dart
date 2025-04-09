import 'package:aaraadhya_temple_dashboard/core/enums/pooja_type.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/poojas_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/view_pooja_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoojasGrid extends ConsumerWidget {
  const PoojasGrid({super.key, required this.poojaType, this.searchquery});

  final PoojaType poojaType;
  final String? searchquery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poojasControllerProvider);

    final poojas =
        state.poojas.where((pooja) {
          if (searchquery != null && searchquery!.isNotEmpty) {
            return pooja.poojaType == poojaType &&
                pooja.name.toLowerCase().contains(searchquery!.toLowerCase());
          }
          return pooja.poojaType == poojaType;
        }).toList();

    return state.isLoading
        ? ShimmerLoader(
          isLoading: state.isLoading,
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colors.grey[50],
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        )
        : poojas.isNotEmpty
        ? GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          crossAxisCount: 2,
          children: List.generate(poojas.length, (index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: context.colorScheme.surface,
                  barrierDismissible: false,
                  builder:
                      (context) => ViewPoojaDetailsDialog(pooja: poojas[index]),
                );
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        image: DecorationImage(
                          image: NetworkImage(poojas[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [context.colors.black, Colors.transparent],
                          stops: [0.0, 1],
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poojas[index].name,
                          style: context.theme.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppSpacing.verticalSmall,
                        Text(
                          poojas[index].description,
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.surface,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.block_outlined, size: 72),
            AppSpacing.verticalMedium,
            Text(context.l10n.poojaListEmptyText),
          ],
        );
  }
}
