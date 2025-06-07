import 'package:aaraadhya_temple_dashboard/core/enums/pooja_time.dart';
import 'package:aaraadhya_temple_dashboard/core/enums/schedule_mode.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pooja_schedule.freezed.dart';
part 'pooja_schedule.g.dart';

@freezed
class PoojaSchedule with _$PoojaSchedule {
  const factory PoojaSchedule({
    required String id,
    required String templeId,
    required Pooja pooja,
    required bool isActive,
    required String price,
    required String deityName,
    required ScheduleMode? scheduleMode,
    required List<bool>? poojaDays,
    required PoojaTime? poojaTime,
    required DateTime? poojaDateAndTime,
    required List<String> keywords,
    required DateTime createdAt,
    required DateTime? updatedAt,
  }) = _PoojaSchedule;

  factory PoojaSchedule.empty() => PoojaSchedule(
    id: '',
    templeId: '',
    pooja: Pooja.empty(),
    isActive: true,
    price: '',
    deityName: '',
    scheduleMode: null,
    poojaDays: null,
    poojaTime: null,
    poojaDateAndTime: null,
    keywords: [],
    createdAt: DateTime.now(),
    updatedAt: null,
  );

  const PoojaSchedule._();

  bool get isEmpty =>
      price.isEmpty ||
      deityName.isEmpty ||
      scheduleMode == null ||
      (scheduleMode == ScheduleMode.repeat && poojaTime == null) ||
      (scheduleMode == ScheduleMode.repeat &&
          (poojaDays == null || !poojaDays!.contains(true))) ||
      (scheduleMode == ScheduleMode.once && poojaDateAndTime == null);

  factory PoojaSchedule.fromJson(Map<String, dynamic> json) =>
      _$PoojaScheduleFromJson(json);
}
