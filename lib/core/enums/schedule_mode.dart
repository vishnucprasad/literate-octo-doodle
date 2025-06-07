import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

enum ScheduleMode { repeat, once }

extension ScheduleModeExtension on ScheduleMode {
  String getName(BuildContext context) {
    switch (this) {
      case ScheduleMode.repeat:
        return context.l10n.repeatModeLabel;
      case ScheduleMode.once:
        return context.l10n.onceOnlyModeLabel;
    }
  }
}
