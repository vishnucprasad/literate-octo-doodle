import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

enum PoojaTime { morning, evening }

extension PoojaTimeExtension on PoojaTime {
  String getName(BuildContext context) {
    switch (this) {
      case PoojaTime.morning:
        return context.l10n.morningLabel;
      case PoojaTime.evening:
        return context.l10n.eveningLabel;
    }
  }
}
