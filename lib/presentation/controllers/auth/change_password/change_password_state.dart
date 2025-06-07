import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(false) bool isChanging,
    @Default('') String currentPassword,
    @Default('') String newPassword,
    @Default('') String confirmPassword,
    @Default(null) ValidationError? currentPasswordValidationError,
    @Default(null) ValidationError? newPasswordValidationError,
    @Default(null) ValidationError? confirmPasswordValidationError,
    @Default(false) bool showValidationErrors,
    BaseException? error,
  }) = _ChangePasswordState;

  const ChangePasswordState._();

  bool get isValid =>
      currentPassword.isNotEmpty &&
      newPassword.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      currentPasswordValidationError == null &&
      newPasswordValidationError == null &&
      confirmPasswordValidationError == null &&
      !isChanging;
}
