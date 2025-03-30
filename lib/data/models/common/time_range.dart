import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_range.freezed.dart';

@freezed
class TimeRange with _$TimeRange {
  const factory TimeRange({
    @Default(null) TimeOfDay? startTime,
    @Default(null) TimeOfDay? endTime,
  }) = _TimeRange;
}
