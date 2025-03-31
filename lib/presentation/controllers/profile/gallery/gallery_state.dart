import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_state.freezed.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    @Default(false) bool selectionModeActive,
    required List<bool> selectedImages,
  }) = _GalleryState;

  factory GalleryState.initial() {
    return GalleryState(selectedImages: List.generate(15, (index) => false));
  }
}
