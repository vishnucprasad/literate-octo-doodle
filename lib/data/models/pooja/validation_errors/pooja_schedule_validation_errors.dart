import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pooja_schedule_validation_errors.freezed.dart';

@freezed
class PoojaScheduleValidationErrors with _$PoojaScheduleValidationErrors {
  const factory PoojaScheduleValidationErrors({
    @Default(false) bool showValidationErrors,
    ValidationError? price,
    ValidationError? deityName,
    ValidationError? scheduleMode,
    ValidationError? poojaDays,
    ValidationError? poojaTime,
    ValidationError? poojaDateAndTime,
  }) = _PoojaScheduleValidationErrors;

  const PoojaScheduleValidationErrors._();

  bool get hasErrors =>
      price != null ||
      deityName != null ||
      scheduleMode != null ||
      poojaDays != null ||
      poojaTime != null ||
      poojaDateAndTime != null;
}
