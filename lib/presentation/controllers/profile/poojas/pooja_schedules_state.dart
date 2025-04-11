import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/validation_errors/pooja_schedule_validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pooja_schedules_state.freezed.dart';

@freezed
class PoojaSchedulesState with _$PoojaSchedulesState {
  const factory PoojaSchedulesState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isEditing,
    @Default(false) bool isDeleting,
    @Default([]) List<PoojaSchedule> schedules,
    required PoojaSchedule schedule,
    @Default(PoojaScheduleValidationErrors())
    PoojaScheduleValidationErrors validationErrors,
    BaseException? error,
  }) = _PoojaSchedulesState;

  factory PoojaSchedulesState.initial() {
    return PoojaSchedulesState(schedule: PoojaSchedule.empty());
  }

  const PoojaSchedulesState._();

  bool get isValid =>
      !validationErrors.hasErrors && !schedule.isEmpty && !isSaving;
}
