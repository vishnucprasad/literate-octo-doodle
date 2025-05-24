import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_controller.g.dart';

@riverpod
class BookingsController extends _$BookingsController {
  @override
  BookingsState build() {
    Future.microtask(loadBookings);
    return BookingsState.initial();
  }

  void selectDate({required int index, DateTime? date}) {
    state = state.copyWith(
      selectedDateIndex: index,
      selectedDate: date ?? state.dateList[index],
    );
    loadBookings();
  }

  Future<void> loadBookings() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final bookingRepository = ref.watch(bookingRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final bookings = await bookingRepository.getAllBookings(
          userId: user.uid,
          date: state.selectedDate,
          status: state.bookingFilter,
        );
        state = state.copyWith(bookings: bookings);
      }
    } on BaseException catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void changeFilter(BookingStatus? status) async {
    state = state.copyWith(bookingFilter: status);
    loadBookings();
  }

  Future<void> updateCompletionStatus({
    required String bookingId,
    required String poojaId,
  }) async {
    final profileRepository = ref.watch(bookingRepositoryProvider);

    try {
      state = state.copyWith(isUpdating: true, error: null);

      await profileRepository.updatePoojaStatus(
        poojaId: poojaId,
        bookingId: bookingId,
      );

      state = state.copyWith(
        bookings:
            state.bookings.map((booking) {
              if (booking.id == bookingId && booking.pooja.id == poojaId) {
                return booking.copyWith(
                  pooja: booking.pooja.copyWith(isCompleted: true),
                );
              }
              return booking;
            }).toList(),
      );
    } on BaseException catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    } finally {
      state = state.copyWith(isUpdating: false);
    }
  }
}
