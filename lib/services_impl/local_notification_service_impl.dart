import 'dart:async';
import 'dart:convert';

import 'package:aaraadhya_temple_dashboard/services/local_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServiceImpl implements LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationServiceImpl(this._flutterLocalNotificationsPlugin);

  final _tapController = StreamController<Map<String, dynamic>>.broadcast();

  @override
  Future<void> init() async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@drawable/ic_stat_notification',
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        final rawPayload = response.payload;
        if (rawPayload != null) {
          final data = jsonDecode(rawPayload) as Map<String, dynamic>;
          _tapController.add(data);
        }
      },
    );
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> data,
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
      payload: jsonEncode(data),
    );
  }

  @override
  Stream<Map<String, dynamic>> get onLocalNotificationTap =>
      _tapController.stream;
}
