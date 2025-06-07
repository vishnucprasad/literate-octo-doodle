import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/notification_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/dashboard/dashboard_controller.dart';
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
    final notificationRepository = ref.watch(notificationRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true);

      final userId = authRepository.getCurrentUser()?.uid;

      if (userId != null) {
        await fcmService.initFCM(userId);
        await localNotificationService.init();

        final message = await fcmService.getInitialMessage();
        if (message != null) {
          state = state.copyWith(isTappedOnNotification: true);
          deleteNotification(message.data["notificationId"]);
        }

        fcmService.onMessage.listen((message) async {
          localNotificationService.showNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: message.notification?.title ?? 'New Booking Received!',
            body: message.notification?.body ?? 'Please verify the payment.',
            data: message.data,
          );

          final notification = await notificationRepository.getNotificationById(
            userId: userId,
            notificationId: message.data['notificationId'],
          );

          if (notification != null) {
            state = state.copyWith(
              notifications: [notification, ...state.notifications],
            );
            ref
                .read(dashboardControllerProvider.notifier)
                .onNewNotification(notification);
          }
        });

        fcmService.onNotificationTap.listen((message) async {
          state = state.copyWith(isTappedOnNotification: true);
          deleteNotification(message.data["notificationId"]);
        });

        localNotificationService.onLocalNotificationTap.listen((data) {
          state = state.copyWith(isTappedOnNotification: true);
          deleteNotification(data["notificationId"]);
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
        state = state.copyWith(notifications: []);
        ref.watch(dashboardControllerProvider.notifier).onClearNotifications();
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
