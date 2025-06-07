import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_data.freezed.dart';

@freezed
class ImageData with _$ImageData {
  const factory ImageData({
    required String fileName,
    required Uint8List bytes,
  }) = _ImageData;
}
