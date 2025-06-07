import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'database_exception.freezed.dart';

@freezed
sealed class DatabaseException
    with _$DatabaseException
    implements BaseException {
  factory DatabaseException.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return const DatabaseException.permissionDenied();
      case 'not-found':
        return const DatabaseException.notFound();
      case 'already-exists':
        return const DatabaseException.alreadyExists();
      case 'cancelled':
        return const DatabaseException.cancelled();
      case 'deadline-exceeded':
        return const DatabaseException.deadlineExceeded();
      case 'unavailable':
        return const DatabaseException.unavailable();
      case 'aborted':
        return const DatabaseException.aborted();
      case 'data-loss':
        return const DatabaseException.dataLoss();
      case 'internal':
        return const DatabaseException.internal();
      default:
        return DatabaseException.generic(e.message ?? 'Something went wrong.');
    }
  }

  factory DatabaseException.fromPlatformException(PlatformException e) {
    return DatabaseException.generic(e.message ?? 'Something went wrong.');
  }

  const factory DatabaseException.permissionDenied() = _PermissionDenied;
  const factory DatabaseException.notFound() = _NotFound;
  const factory DatabaseException.alreadyExists() = _AlreadyExists;
  const factory DatabaseException.cancelled() = _Cancelled;
  const factory DatabaseException.deadlineExceeded() = _DeadlineExceeded;
  const factory DatabaseException.unavailable() = _Unavailable;
  const factory DatabaseException.aborted() = _Aborted;
  const factory DatabaseException.dataLoss() = _DataLoss;
  const factory DatabaseException.internal() = _Internal;
  const factory DatabaseException.generic(String message) = _Generic;
  const factory DatabaseException.unexpected(String? error) = _unexpected;
}

extension DatabaseExceptionExtension on DatabaseException {
  String getDatabaseExceptionMessage(BuildContext context) {
    return when(
      permissionDenied: () => context.l10n.permissionDeniedErrorMessage,
      notFound: () => context.l10n.notFoundErrorMessage,
      alreadyExists: () => context.l10n.alreadyExistsErrorMessage,
      cancelled: () => context.l10n.cancelledErrorMessage,
      deadlineExceeded: () => context.l10n.deadlineExceededErrorMessage,
      unavailable: () => context.l10n.unavailableErrorMessage,
      aborted: () => context.l10n.abortedErrorMessage,
      dataLoss: () => context.l10n.dataLossErrorMessage,
      internal: () => context.l10n.internalErrorMessage,
      generic: (message) => message,
      unexpected: (error) => error ?? context.l10n.defaultErrorMessage,
    );
  }
}
