import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/notification/notification.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/notification_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository.g.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications({required String userId});
  Future<Notification?> getNotificationById({
    required String userId,
    required String notificationId,
  });
  Future<void> clearAllNotifications({required String userId});
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  });
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryImpl(ref.watch(dbDatasourceProvider));
}
