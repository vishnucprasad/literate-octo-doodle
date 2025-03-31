import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/gallery/gallery_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gallery_controller.g.dart';

@riverpod
class GalleryController extends _$GalleryController {
  @override
  GalleryState build() {
    return GalleryState.initial();
  }

  void selectImage(index) {
    state = state.copyWith(
      selectedImages:
          state.selectedImages.asMap().entries.map((entry) {
            if (entry.key == index) {
              return !entry.value;
            }
            return entry.value;
          }).toList(),
    );
  }

  void changeSelectMode(bool isActive) {
    state = state.copyWith(selectionModeActive: isActive);
  }

  bool get isAnySelected => state.selectedImages.any((value) => value == true);
}
