import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_exception.freezed.dart';

@freezed
sealed class AuthException with _$AuthException implements BaseException {
  factory AuthException.fromFirebaseAuthException(
    FirebaseAuthException exception,
  ) {
    switch (exception.code) {
      case 'invalid-email':
        return const AuthException.invalidEmail();
      case 'user-disabled':
        return const AuthException.userDisabled();
      case 'user-not-found':
        return const AuthException.userNotFound();
      case 'operation-not-allowed':
        return const AuthException.operationNotAllowed();
      case 'invalid-credential':
        return const AuthException.invalidCredential();
      case 'too-many-requests':
        return const AuthException.tooManyRequests();
      default:
        return AuthException.generic(
          exception.message ?? 'An unknown error occurred.',
        );
    }
  }

  const factory AuthException.invalidEmail() = _InvalidEmail;
  const factory AuthException.invalidCredential() = _InvalidCredential;
  const factory AuthException.userNotFound() = _UserNotFound;
  const factory AuthException.userDisabled() = _UserDisabled;
  const factory AuthException.operationNotAllowed() = _OperationNotAllowed;
  const factory AuthException.tooManyRequests() = _TooManyRequests;
  const factory AuthException.generic(String message) = _Generic;
  const factory AuthException.unexpected(String? error) = _unExpected;
}

extension AuthExceptionExtension on AuthException {
  String getAuthExceptionMessage(BuildContext context) {
    return when(
      invalidEmail: () => context.l10n.invalidEmailErrorMessage,
      invalidCredential: () => context.l10n.invalidCredentialsErrorMessage,
      userNotFound: () => context.l10n.userNotFoundErrorMessage,
      userDisabled: () => context.l10n.userDisabledErrorMessage,
      operationNotAllowed: () => context.l10n.operationNotAllowedErrorMessage,
      tooManyRequests: () => context.l10n.tooManyRequestsErrorMessage,
      generic: (message) => message,
      unexpected: (error) => error ?? context.l10n.defaultErrorMessage,
    );
  }
}
