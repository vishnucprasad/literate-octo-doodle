import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/auth/validation_errors/validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(false) bool isSubmitting,
    @Default('') String email,
    @Default(ValidationErrors()) ValidationErrors validationErrors,
    @Default(null) AuthException? error,
  }) = _ForgotPasswordState;

  const ForgotPasswordState._();

  bool get isValid =>
      !validationErrors.hasErrors && email.isNotEmpty && !isSubmitting;
}
