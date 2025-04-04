import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_picker_exeception.freezed.dart';

@freezed
class ImagePickerExeception
    with _$ImagePickerExeception
    implements BaseException {
  const factory ImagePickerExeception.cancelled() = _Cancelled;
  const factory ImagePickerExeception.unexpected(String? error) = _Unexpected;
}

extension ImagePickerExeceptionExtension on ImagePickerExeception {
  String getImagePickerExeceptionMessage(BuildContext context) {
    return when(
      cancelled: () => context.l10n.cancelledErrorMessage,
      unexpected: (error) => error ?? context.l10n.defaultErrorMessage,
    );
  }
}
