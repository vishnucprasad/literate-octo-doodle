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

      state = state.copyWith(isLoading: false, error: null);
    } on BaseException catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }
}
