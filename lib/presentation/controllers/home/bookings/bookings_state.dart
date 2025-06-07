import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookings_state.freezed.dart';

@freezed
class BookingsState with _$BookingsState {
  const factory BookingsState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdating,
    @Default(1) int selectedDateIndex,
    required DateTime selectedDate,
    required List<DateTime> dateList,
    @Default([]) List<Booking> bookings,
    @Default(null) BookingStatus? bookingFilter,
    @Default(null) BaseException? error,
  }) = _BookingsState;

  factory BookingsState.initial() => BookingsState(
    selectedDate: DateTime.now(),
    dateList: [
      DateTime.now(),
      ...List.generate(7, (index) => DateTime.now().add(Duration(days: index))),
    ],
  );
}
