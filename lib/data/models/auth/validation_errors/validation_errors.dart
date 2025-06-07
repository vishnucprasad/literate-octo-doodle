import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_errors.freezed.dart';

@freezed
abstract class ValidationErrors with _$ValidationErrors {
  const factory ValidationErrors({
    @Default(false) bool showValidationErrors,
    ValidationError? email,
    ValidationError? password,
  }) = _ValidationErrors;

  const ValidationErrors._();

  bool get hasErrors => email != null || password != null;
}
