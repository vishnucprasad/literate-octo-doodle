import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/notification/notification.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/dashboard_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/dashboard/dashboard_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller.g.dart';

@riverpod
class DashboardController extends _$DashboardController {
  @override
  DashboardState build() {
    Future.microtask(loadData);
    return DashboardState();
  }

  Future<void> loadData() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final dashboardRepository = ref.watch(dashboardRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true);

      final user = authRepository.getCurrentUser();
      if (user == null) throw const AuthException.userNotFound();

      final data = await dashboardRepository.loadDashboardData(
        userId: user.uid,
      );
      state = state.copyWith(data: data);
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void onNewNotification(Notification notification) {
    state = state.copyWith(
      data: state.data.copyWith(
        latestNotifications: [
          notification,
          ...state.data.latestNotifications.skip(
            state.data.latestNotifications.length > 2 ? 1 : 0,
          ),
        ],
      ),
    );
  }

  void onClearNotifications() {
    state = state.copyWith(data: state.data.copyWith(latestNotifications: []));
  }
}
