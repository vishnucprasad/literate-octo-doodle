import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_details_validation_errors.freezed.dart';

@freezed
class BankDetailsValidationErrors with _$BankDetailsValidationErrors {
  const factory BankDetailsValidationErrors({
    ValidationError? bankName,
    ValidationError? accountHolderName,
    ValidationError? accountNumber,
    ValidationError? ifscCode,
    ValidationError? upiId,
  }) = _BankDetailsValidationErrors;

  const BankDetailsValidationErrors._();

  bool get hasErrors =>
      bankName != null ||
      accountHolderName != null ||
      accountNumber != null ||
      ifscCode != null ||
      upiId != null;
}
