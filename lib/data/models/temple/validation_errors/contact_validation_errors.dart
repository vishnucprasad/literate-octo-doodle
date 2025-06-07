import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_validation_errors.freezed.dart';

@freezed
abstract class ContactValidationErrors with _$ContactValidationErrors {
  const factory ContactValidationErrors({
    ValidationError? name,
    ValidationError? phoneNumber,
  }) = _ContactValidationErrors;

  const ContactValidationErrors._();

  bool get hasErrors => name != null || phoneNumber != null;
}
