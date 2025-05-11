import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_details_validation_errors.freezed.dart';

@freezed
abstract class BasicDetailsValidationErrors
    with _$BasicDetailsValidationErrors {
  const factory BasicDetailsValidationErrors({
    @Default(false) bool showValidationErrors,
    ValidationError? templeName,
    ValidationError? mainDeityName,
    ValidationError? otherDeities,
    ValidationError? managingAuthority,
    ValidationError? morningSchedule,
    ValidationError? eveningSchedule,
    ValidationError? amenities,
    ValidationError? templeHistory,
    ValidationError? description,
    ValidationError? rules,
  }) = _BasicDetailsValidationErrors;

  const BasicDetailsValidationErrors._();

  bool get hasErrors =>
      templeName != null ||
      mainDeityName != null ||
      otherDeities != null ||
      managingAuthority != null ||
      morningSchedule != null ||
      eveningSchedule != null ||
      amenities != null ||
      templeHistory != null ||
      description != null ||
      rules != null;
}
