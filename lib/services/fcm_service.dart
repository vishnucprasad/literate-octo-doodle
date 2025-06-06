import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/di/firebase_providers.dart';
import 'package:aaraadhya_temple_dashboard/services_impl/fcm_service_impl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_service.g.dart';

abstract class FcmService {
  Future<void> initFCM(String userId);
  Future<RemoteMessage?> getInitialMessage();
  Stream<RemoteMessage> get onMessage;
  Stream<RemoteMessage> get onNotificationTap;
}

@riverpod
FcmService fcmService(Ref ref) {
  return FcmServiceImpl(
    ref.watch(firebaseMessagingProvider),
    ref.watch(dbDatasourceProvider),
  );
}
