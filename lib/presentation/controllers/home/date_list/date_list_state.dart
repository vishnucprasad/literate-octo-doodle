import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_list_state.freezed.dart';

@freezed
class DateListState with _$DateListState {
  const factory DateListState({
    @Default(0) int selectedDateIndex,
    required DateTime selectedDate,
    required List<DateTime> dateList,
  }) = _DateListState;

  factory DateListState.initial() => DateListState(
    selectedDate: DateTime.now(),
    dateList: List.generate(
      30,
      (index) => DateTime.now().add(Duration(days: index)),
    ),
  );
}
