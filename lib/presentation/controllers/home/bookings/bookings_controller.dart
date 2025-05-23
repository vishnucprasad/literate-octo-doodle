import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/bookings/bookings_state.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/date_list/date_list_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bookings_controller.g.dart';

@riverpod
class BookingsController extends _$BookingsController {
  @override
  BookingsState build() {
    Future.microtask(loadBookings);
    return BookingsState();
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
          date: ref.watch(dateListControllerProvider).selectedDate,
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

  Future<void> updateCompletionStatus({
    required String bookingId,
    required String poojaId,
    required bool isCompleted,
  }) async {
    final profileRepository = ref.watch(bookingRepositoryProvider);

    try {
      state = state.copyWith(isUpdating: true, error: null);

      await profileRepository.updatePoojaCompletionStatus(
        id: poojaId,
        bookingId: bookingId,
        value: isCompleted,
      );

      state = state.copyWith(
        bookings:
            state.bookings.map((booking) {
              if (booking.id == bookingId && booking.pooja.id == poojaId) {
                return booking.copyWith(
                  pooja: booking.pooja.copyWith(isCompleted: isCompleted),
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
