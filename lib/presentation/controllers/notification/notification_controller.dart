import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/notification_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/notification/notification_state.dart';
import 'package:aaraadhya_temple_dashboard/services/fcm_service.dart';
import 'package:aaraadhya_temple_dashboard/services/local_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_controller.g.dart';

@riverpod
class NotificationController extends _$NotificationController {
  @override
  NotificationState build() {
    Future.microtask(initFcmAndListenToNotifications);
    return NotificationState();
  }

  Future<void> initFcmAndListenToNotifications() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final fcmService = ref.watch(fcmServiceProvider);
    final localNotificationService = ref.watch(
      localNotificationServiceProvider,
    );

    try {
      state = state.copyWith(isLoading: true);

      final userId = authRepository.getCurrentUser()?.uid;

      if (userId != null) {
        await fcmService.initFCM(userId);
        await localNotificationService.init();

        fcmService.onMessage.listen((message) async {
          state = state.copyWith(count: state.count + 1);
          localNotificationService.showNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: message.notification?.title ?? 'New Booking Received!',
            body: message.notification?.body ?? 'Please verify the payment.',
          );
        });

        fcmService.onNotificationTap.listen((message) async {
          await deleteNotification(message.data["notificationId"]);
          state = state.copyWith(
            count: state.count - 1,
            isTappedOnNotification: true,
          );
        });

        await getNotifications();
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> getNotifications() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final notificationRepository = ref.watch(notificationRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true);
      final userId = authRepository.getCurrentUser()?.uid;

      if (userId != null) {
        final notifications = await notificationRepository.getNotifications(
          userId: userId,
        );

        state = state.copyWith(notifications: notifications);
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final authRepository = ref.watch(authRepositoryProvider);
    final notificationRepository = ref.watch(notificationRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true);
      final userId = authRepository.getCurrentUser()?.uid;

      if (userId != null) {
        await notificationRepository.deleteNotification(
          userId: userId,
          notificationId: notificationId,
        );

        state = state.copyWith(
          notifications:
              state.notifications
                  .where((notification) => notification.id != notificationId)
                  .toList(),
          count: state.count - 1,
        );
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> clearAllNotifications() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final notificationRepository = ref.watch(notificationRepositoryProvider);

    try {
      state = state.copyWith(isClearing: true);
      final userId = authRepository.getCurrentUser()?.uid;

      if (userId != null) {
        await notificationRepository.clearAllNotifications(userId: userId);

        state = state.copyWith(notifications: [], count: 0);
      }
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: DatabaseException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isClearing: false);
    }
  }
}
