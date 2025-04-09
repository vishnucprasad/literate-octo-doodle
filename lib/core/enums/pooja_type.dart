import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

enum PoojaType { pooja, specialPooja }

extension PoojaTypeExtension on PoojaType {
  String getName(BuildContext context) {
    switch (this) {
      case PoojaType.pooja:
        return context.l10n.poojaLabel;
      case PoojaType.specialPooja:
        return context.l10n.specialPoojaLabel;
    }
  }
}
