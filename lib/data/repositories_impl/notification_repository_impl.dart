import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/notification/notification.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/notification_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final DbDatasource _dbDatasource;

  NotificationRepositoryImpl(this._dbDatasource);

  @override
  Future<List<Notification>> getNotifications({required String userId}) async {
    return await _dbDatasource
        .queryCollection('temples/$userId/notifications', orderBy: 'createdAt')
        .then((data) {
          return data
              .map(
                (doc) => Notification.fromJson({
                  ...doc,
                  "createdAt":
                      (doc['createdAt'] as Timestamp)
                          .toDate()
                          .toIso8601String(),
                }),
              )
              .toList();
        });
  }

  @override
  Future<Notification?> getNotificationById({
    required String userId,
    required String notificationId,
  }) async {
    final notification = await _dbDatasource.getDocument(
      'temples/$userId/notifications',
      notificationId,
    );

    if (notification != null) {
      return Notification.fromJson({
        ...notification,
        "createdAt":
            (notification['createdAt'] as Timestamp).toDate().toIso8601String(),
      });
    }
    return null;
  }

  @override
  Future<void> clearAllNotifications({required String userId}) async {
    return await _dbDatasource.deleteCollection(
      'temples/$userId/notifications',
    );
  }

  @override
  Future<void> deleteNotification({
    required String userId,
    required String notificationId,
  }) async {
    return await _dbDatasource.deleteDocument(
      'temples/$userId/notifications',
      notificationId,
    );
  }
}
