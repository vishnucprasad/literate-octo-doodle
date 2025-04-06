import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryGridView extends ConsumerWidget {
  const GalleryGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleryControllerProvider);
    final controller = ref.read(galleryControllerProvider.notifier);

    return state.isLoading
        ? ShimmerLoader(
          isLoading: state.isLoading,
          child: GridView.count(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.outline,
                  borderRadius: BorderRadius.circular(14.0),
                ),
              );
            }),
          ),
        )
        : state.images.isEmpty
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported_outlined, size: 72),
            AppSpacing.verticalMedium,
            Text(context.l10n.noImagesInGalleryText),
          ],
        )
        : GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          crossAxisCount: 3,
          children: List.generate(state.images.length, (index) {
            return GestureDetector(
              onLongPress: () {
                controller.changeSelectMode(true);
                controller.selectImage(index);
              },
              onTap: () {
                if (state.selectionModeActive) {
                  controller.selectImage(index);

                  if (!controller.isAnySelected) {
                    controller.changeSelectMode(false);
                  }
                }
              },
              child: Stack(
                children: [
                  ShimmerLoader(
                    isLoading: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.outline,
                        borderRadius: BorderRadius.circular(14.0),
                        border:
                            state.selectedImages[index]
                                ? Border.all(
                                  color: context.colorScheme.primary,
                                  width: 3,
                                )
                                : null,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(state.images[index].url),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.0),
                      border:
                          state.selectedImages[index]
                              ? Border.all(
                                color: context.colorScheme.primary,
                                width: 3,
                              )
                              : null,
                    ),
                  ),
                  if (state.selectedImages[index]) ...[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        );
  }
}
