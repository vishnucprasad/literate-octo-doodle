import 'package:aaraadhya_temple_dashboard/data/models/temple/advanced_options/bank_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'advanced_options.freezed.dart';
part 'advanced_options.g.dart';

@freezed
class AdvancedOptions with _$AdvancedOptions {
  const factory AdvancedOptions({
    bool? smsNotificationForDevotees,
    bool? emailNotificationForDevotees,
    bool? enableOnlineBooking,
    @Default('30') String advancedOnlneBookingLimit,
    @Default(BankDetails()) BankDetails bankDetails,
  }) = _AdvancedOptions;

  factory AdvancedOptions.fromJson(Map<String, dynamic> json) =>
      _$AdvancedOptionsFromJson(json);
}
