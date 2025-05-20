import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/booking_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/date_list/date_list_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payments_controller.g.dart';

@riverpod
class PaymentsController extends _$PaymentsController {
  @override
  PaymentsState build() {
    Future.microtask(loadPayments);
    return PaymentsState();
  }

  Future<void> loadPayments() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(bookingRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final payments = await profileRepository.getPayments(
          userId: user.uid,
          date: ref.watch(dateListControllerProvider).selectedDate,
          status: state.filterStatus,
        );
        state = state.copyWith(payments: payments);
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
    state = state.copyWith(filterStatus: status);
    loadPayments();
  }

  Future<void> verifyPayment({required String paymentId}) async {
    final bookingRepository = ref.watch(bookingRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);
      await bookingRepository.updateBookingStatus(
        bookingId: paymentId,
        status: BookingStatus.confirmed,
      );
      loadPayments();
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

  Future<void> rejectPayment({required String paymentId}) async {
    final bookingRepository = ref.watch(bookingRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);
      await bookingRepository.updateBookingStatus(
        bookingId: paymentId,
        status: BookingStatus.rejected,
      );
      loadPayments();
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
}
