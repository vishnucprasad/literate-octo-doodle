import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GalleryGridView extends ConsumerWidget {
  const GalleryGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleryControllerProvider);
    final controller = ref.read(galleryControllerProvider.notifier);

    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      crossAxisCount: 3,
      children: List.generate(state.selectedImages.length, (index) {
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
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.outline,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color:
                    state.selectedImages[index]
                        ? context.colorScheme.primary
                        : Colors.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              children: [
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
          ),
        );
      }),
    );
  }
}
