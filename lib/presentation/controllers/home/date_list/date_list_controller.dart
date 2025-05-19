import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/date_list/date_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_list_controller.g.dart';

@riverpod
class DateListController extends _$DateListController {
  @override
  DateListState build() {
    return DateListState.initial();
  }

  void selectDate({required int index, DateTime? date}) {
    state = state.copyWith(
      selectedDateIndex: index,
      selectedDate: date ?? state.dateList[index],
    );
  }
}
