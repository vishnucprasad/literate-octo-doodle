import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_storage_exception.freezed.dart';

@freezed
sealed class FirebaseStorageException
    with _$FirebaseStorageException
    implements BaseException {
  factory FirebaseStorageException.fromFirebaseException(
    FirebaseException exception,
  ) {
    switch (exception.code) {
      case 'unauthorized':
        return FirebaseStorageException.unAuthorized();
      case 'quota-exceeded':
        return FirebaseStorageException.quotaExceeded();
      case 'object-not-found':
        return FirebaseStorageException.objectNotFound();
      case 'cancelled':
        return FirebaseStorageException.cancelled();
      case 'unknown':
        return FirebaseStorageException.unknown();
      default:
        return FirebaseStorageException.generic(
          exception.message ?? 'An unknown error occurred.',
        );
    }
  }

  const factory FirebaseStorageException.objectNotFound() = _ObjectNotFound;
  const factory FirebaseStorageException.unAuthorized() = _UnAuthorized;
  const factory FirebaseStorageException.cancelled() = _Cancelled;
  const factory FirebaseStorageException.unknown() = _Unknown;
  const factory FirebaseStorageException.quotaExceeded() = _QuotaExceeded;
  const factory FirebaseStorageException.generic(String message) = _Generic;
  const factory FirebaseStorageException.unexpected(String? error) =
      _Unexpected;
}

extension FirebaseStorageExceptionX on FirebaseStorageException {
  String getFirebaseStorageExceptionMessage(BuildContext context) {
    return when(
      objectNotFound: () => context.l10n.objectNotFoundErrorMessage,
      unAuthorized: () => context.l10n.unAuthorizedErrorMessage,
      cancelled: () => context.l10n.cancelledErrorMessage,
      unknown: () => context.l10n.unknownErrorMessage,
      quotaExceeded: () => context.l10n.quotaExceededErrorMessage,
      generic: (message) => message,
      unexpected: (error) => error ?? context.l10n.defaultErrorMessage,
    );
  }
}
