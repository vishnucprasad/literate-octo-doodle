import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/auth/credentials/credentials.dart';
import 'package:aaraadhya_temple_dashboard/data/models/auth/validation_errors/validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_state.freezed.dart';

@freezed
abstract class SigninState with _$SigninState {
  const factory SigninState({
    @Default(false) bool isSubmitting,
    @Default(Credentials()) Credentials credentials,
    @Default(ValidationErrors()) ValidationErrors validationErrors,
    @Default(null) AuthException? error,
  }) = _SigninState;

  const SigninState._();

  bool get isValid =>
      !validationErrors.hasErrors && !credentials.isEmpty && !isSubmitting;
}
