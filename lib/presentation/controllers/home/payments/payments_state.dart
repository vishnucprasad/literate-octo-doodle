import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/payment/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments_state.freezed.dart';

@freezed
class PaymentsState with _$PaymentsState {
  const factory PaymentsState({
    @Default(false) bool isLoading,
    @Default(1) int selectedDateIndex,
    required DateTime selectedDate,
    required List<DateTime> dateList,
    @Default([]) List<Payment> payments,
    @Default(null) BookingStatus? filterStatus,
    @Default(null) BaseException? error,
  }) = _PaymentsState;

  factory PaymentsState.initial() => PaymentsState(
    selectedDate: DateTime.now(),
    dateList: [
      DateTime.now(),
      ...List.generate(7, (index) {
        return DateTime.now().subtract(Duration(days: index));
      }),
    ],
  );
}
