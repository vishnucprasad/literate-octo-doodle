import 'package:aaraadhya_temple_dashboard/services_impl/local_notification_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:aaraadhya_temple_dashboard/di/providers.dart';

part 'local_notification_service.g.dart';

abstract class LocalNotificationService {
  Future<void> init();
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });
}

@riverpod
LocalNotificationService localNotificationService(Ref ref) {
  return LocalNotificationServiceImpl(
    ref.watch(flutterLocalNotificationsPluginProvider),
  );
}
