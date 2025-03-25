import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_details_controller.g.dart';

@riverpod
class BookingDetailsController extends _$BookingDetailsController {
  @override
  int? build() {
    return null;
  }

  void setIndex(int? index) {
    state = index;
  }
}
