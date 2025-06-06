import 'dart:async';

import 'package:aaraadhya_temple_dashboard/core/exceptions/fcm_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/services/fcm_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmServiceImpl implements FcmService {
  final FirebaseMessaging _firebaseMessaging;
  final DbDatasource _dbDatasource;

  final _messageController = StreamController<RemoteMessage>.broadcast();
  final _notificationTapController =
      StreamController<RemoteMessage>.broadcast();

  FcmServiceImpl(this._firebaseMessaging, this._dbDatasource) {
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _messageController.add(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _notificationTapController.add(message);
    });
  }

  @override
  Future<void> initFCM(String userId) async {
    try {
      final settings = await _firebaseMessaging.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        throw const FcmException.permissionDenied();
      }

      final token = await _firebaseMessaging.getToken();
      if (token == null) {
        throw const FcmException.tokenFetchFailed();
      }

      await _dbDatasource.updateDocument('temples', userId, {
        'fcmTokens': FieldValue.arrayUnion([token]),
      });

      _firebaseMessaging.onTokenRefresh.listen((newToken) async {
        try {
          await _dbDatasource.updateDocument('temples', userId, {
            'fcmTokens': FieldValue.arrayUnion([newToken]),
          });
        } catch (e) {
          throw FcmException.unexpected(e.toString());
        }
      });
    } catch (e) {
      if (e is FcmException) {
        rethrow;
      } else {
        throw FcmException.unexpected(e.toString());
      }
    }
  }

  @override
  Stream<RemoteMessage> get onMessage => _messageController.stream;

  @override
  Stream<RemoteMessage> get onNotificationTap =>
      _notificationTapController.stream;
}
