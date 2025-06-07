import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_basic_detaiils/temple_basic_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/validation_errors/basic_details_validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_details_state.freezed.dart';

@freezed
class BasicDetailsState with _$BasicDetailsState {
  const factory BasicDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isUploading,
    @Default(false) bool isSaving,
    @Default(false) bool isFormEnabled,
    @Default(TempleBasicDetails()) TempleBasicDetails basicDetails,
    @Default(BasicDetailsValidationErrors())
    BasicDetailsValidationErrors validationErrors,
    @Default(null) BaseException? error,
  }) = _BasicDetailsState;

  const BasicDetailsState._();

  bool get isValid =>
      !validationErrors.hasErrors && !basicDetails.isEmpty && !isSaving;
}
