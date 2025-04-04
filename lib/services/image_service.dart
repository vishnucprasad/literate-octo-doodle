import 'package:aaraadhya_temple_dashboard/di/providers.dart';
import 'package:aaraadhya_temple_dashboard/services_impl/image_service_impl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_service.g.dart';

abstract class ImageService {
  Future<Uint8List> pickAndCropImage();
}

@riverpod
ImageService imageService(Ref ref) {
  final imagePicker = ref.watch(imagePickerProvider);
  final imageCropper = ref.watch(imageCropperProvider);
  return ImageServiceImpl(imagePicker, imageCropper);
}
