import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

enum TempleManagingAuthority {
  devaswomBoard,
  privateTrust,
  familyTrust,
  others,
}

extension TempleManagingAuthorityExtension on TempleManagingAuthority {
  String getName(BuildContext context) {
    switch (this) {
      case TempleManagingAuthority.devaswomBoard:
        return context.l10n.devaswomBoardLabel;
      case TempleManagingAuthority.privateTrust:
        return context.l10n.privateTrustLabel;
      case TempleManagingAuthority.familyTrust:
        return context.l10n.familyTrustLabel;
      case TempleManagingAuthority.others:
        return context.l10n.othersLabel;
    }
  }
}
