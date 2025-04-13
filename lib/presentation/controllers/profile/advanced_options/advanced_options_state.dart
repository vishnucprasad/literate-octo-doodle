import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/advanced_options/advanced_options.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/validation_errors/bank_details_validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'advanced_options_state.freezed.dart';

@freezed
class AdvancedOptionsState with _$AdvancedOptionsState {
  const factory AdvancedOptionsState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(AdvancedOptions()) AdvancedOptions advancedOptions,
    @Default(BankDetailsValidationErrors())
    BankDetailsValidationErrors validationErrors,
    @Default(null) ValidationError? advancedBookingLimitValidationErorr,
    @Default(null) BaseException? error,
  }) = _AdvancedOptionsState;

  const AdvancedOptionsState._();

  bool get isValid =>
      !validationErrors.hasErrors &&
      !advancedOptions.bankDetails.isEmpty &&
      !isSaving;
}
