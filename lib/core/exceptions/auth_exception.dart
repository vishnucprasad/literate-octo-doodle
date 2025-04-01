import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_exception.freezed.dart';

@freezed
sealed class AuthException with _$AuthException {
  const factory AuthException.invalidEmail() = _InvalidEmail;
  const factory AuthException.invalidCredential() = _InvalidCredential;
  const factory AuthException.userNotFound() = _UserNotFound;
  const factory AuthException.userDisabled() = _UserDisabled;
  const factory AuthException.operationNotAllowed() = _OperationNotAllowed;
  const factory AuthException.tooManyRequests() = _TooManyRequests;
  const factory AuthException.generic(String message) = _Generic;
  const factory AuthException.unexpected(String error) = _unExpected;
}
