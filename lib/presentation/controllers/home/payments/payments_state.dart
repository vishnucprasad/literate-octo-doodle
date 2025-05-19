import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/payment/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments_state.freezed.dart';

@freezed
class PaymentsState with _$PaymentsState {
  const factory PaymentsState({
    @Default(false) bool isLoading,
    @Default([]) List<Payment> payments,
    @Default(BookingStatus.pending) BookingStatus filterStatus,
    @Default(null) BaseException? error,
  }) = _PaymentsState;
}
