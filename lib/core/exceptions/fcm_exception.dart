import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_exception.freezed.dart';

@freezed
sealed class FcmException with _$FcmException implements BaseException {
  const factory FcmException.permissionDenied() = _PermissionDenied;
  const factory FcmException.tokenFetchFailed() = _TokenFetchFailed;
  const factory FcmException.messageHandlingFailed() = _MessageHandlingFailed;
  const factory FcmException.unexpected(String? error) = _Unexpected;
}

extension FcmExceptionExtension on FcmException {
  String getFcmExceptionMessage(BuildContext context) {
    return when(
      permissionDenied: () => context.l10n.fcmPermissionDenied,
      tokenFetchFailed: () => context.l10n.fcmTokenFetchFailed,
      messageHandlingFailed: () => context.l10n.fcmMessageHandlingFailed,
      unexpected: (error) => error ?? context.l10n.defaultErrorMessage,
    );
  }
}
