import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expandable_container_controller.g.dart';

@riverpod
class ExpandableContainerController extends _$ExpandableContainerController {
  @override
  int? build() {
    return null;
  }

  void setIndex(int? index) {
    state = index;
  }
}
