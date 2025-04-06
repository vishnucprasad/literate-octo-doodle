import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_details_validation_errors.freezed.dart';

@freezed
class BankDetailsValidationErrors with _$BankDetailsValidationErrors {
  const factory BankDetailsValidationErrors({
    ValidationError? bankName,
    ValidationError? accountNumber,
    ValidationError? ifscCode,
    ValidationError? accountHolderName,
  }) = _BankDetailsValidationErrors;

  const BankDetailsValidationErrors._();

  bool get hasErrors =>
      bankName != null ||
      accountNumber != null ||
      ifscCode != null ||
      accountHolderName != null;
}
