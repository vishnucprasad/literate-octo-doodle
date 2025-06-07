import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewImageDialog extends ConsumerWidget {
  const ViewImageDialog({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController(initialPage: initialIndex);
    final state = ref.watch(galleryControllerProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: state.images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: InteractiveViewer(
                  child: Center(
                    child: Hero(
                      tag: state.images[index].url,
                      child: Image.network(
                        state.images[index].url,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const CircularProgressIndicator();
                        },
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.error, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: context.colorScheme.onSurface,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
