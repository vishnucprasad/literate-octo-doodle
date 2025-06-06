import 'package:aaraadhya_temple_dashboard/services/local_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServiceImpl implements LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationServiceImpl(this._flutterLocalNotificationsPlugin);

  @override
  Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@drawable/ic_stat_notification',
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
