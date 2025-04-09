import 'package:aaraadhya_temple_dashboard/core/exceptions/image_picker_exeception.dart';
import 'package:aaraadhya_temple_dashboard/core/theme/app_colors.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/image_data.dart';
import 'package:aaraadhya_temple_dashboard/services/image_service.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageServiceImpl implements ImageService {
  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  ImageServiceImpl(this._imagePicker, this._imageCropper);

  @override
  Future<ImageData> pickAndCropImage({CropAspectRatio? cropAspectRatio}) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage == null) throw ImagePickerExeception.cancelled();

      final CroppedFile? croppedFile = await _imageCropper.cropImage(
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors().white,
            toolbarWidgetColor: AppColors().primary,
            statusBarColor: AppColors().white,
            activeControlsWidgetColor: AppColors().white,
            backgroundColor: AppColors().white,
            cropGridColor: AppColors().white,
            cropFrameColor: AppColors().white,
            cropGridStrokeWidth: 4,
            cropFrameStrokeWidth: 4,
            lockAspectRatio: cropAspectRatio != null,
            hideBottomControls: true,
            dimmedLayerColor: AppColors().black.withValues(alpha: 0.25),
          ),
        ],
        aspectRatio: cropAspectRatio,
        sourcePath: pickedImage.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 80,
      );

      if (croppedFile == null) throw ImagePickerExeception.cancelled();

      return ImageData(
        fileName: pickedImage.name,
        bytes: await croppedFile.readAsBytes(),
      );
    } on ImagePickerExeception {
      rethrow;
    } on PlatformException catch (e) {
      throw ImagePickerExeception.unexpected(e.toString());
    }
  }
}
