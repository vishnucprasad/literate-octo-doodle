import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

enum BookingStatus {
  pending,
  confirmed,
  canceled,
  completed,
  rejected,
  refunded,
}

extension BookingStatusExtension on BookingStatus {
  String getName(BuildContext context) {
    switch (this) {
      case BookingStatus.pending:
        return context.l10n.pendingBadgeLabel;
      case BookingStatus.confirmed:
        return context.l10n.confirmedBadgeLabel;
      case BookingStatus.canceled:
        return context.l10n.canceledBadgeLabel;
      case BookingStatus.completed:
        return context.l10n.completedBadgeLabel;
      case BookingStatus.rejected:
        return context.l10n.rejectedBadgeLabel;
      case BookingStatus.refunded:
        return context.l10n.refundedBadgeLabel;
    }
  }
}
