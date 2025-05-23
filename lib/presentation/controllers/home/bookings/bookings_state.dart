import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookings_state.freezed.dart';

@freezed
class BookingsState with _$BookingsState {
  const factory BookingsState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    @Default([]) List<Booking> bookings,
    @Default(null) BaseException? error,
  }) = _BookingsState;
}
