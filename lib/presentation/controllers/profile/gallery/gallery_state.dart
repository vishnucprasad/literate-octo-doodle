import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_gallery/gallery_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_state.freezed.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    @Default(false) bool isLoading,
    @Default(false) bool isUploading,
    @Default(false) bool isDeleting,
    @Default(false) bool selectionModeActive,
    @Default([]) List<bool> selectedImages,
    @Default([]) List<GalleryItem> images,
    BaseException? error,
  }) = _GalleryState;
}
