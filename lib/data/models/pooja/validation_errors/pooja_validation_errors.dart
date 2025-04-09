import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pooja_validation_errors.freezed.dart';

@freezed
class PoojaValidationErrors with _$PoojaValidationErrors {
  const factory PoojaValidationErrors({
    @Default(false) bool showValidationErrors,
    ValidationError? poojaImage,
    ValidationError? poojaName,
    ValidationError? poojaType,
    ValidationError? poojaDescription,
  }) = _PoojaValidationErrors;

  const PoojaValidationErrors._();

  bool get hasErrors =>
      poojaImage != null ||
      poojaName != null ||
      poojaType != null ||
      poojaDescription != null;
}
