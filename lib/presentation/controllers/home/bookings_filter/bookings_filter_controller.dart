import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_filter_controller.g.dart';

@riverpod
class BookingsFilterController extends _$BookingsFilterController {
  @override
  int build() {
    return 0;
  }

  void selectIndex(int index) => state = index;
}
