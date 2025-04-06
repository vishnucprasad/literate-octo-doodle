import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_item.freezed.dart';
part 'gallery_item.g.dart';

@freezed
class GalleryItem with _$GalleryItem {
  const factory GalleryItem({
    required String id,
    required String url,
    required String fileName,
    required DateTime uploadedAt,
  }) = _GalleryItem;

  factory GalleryItem.fromJson(Map<String, dynamic> json) =>
      _$GalleryItemFromJson(json);
}
