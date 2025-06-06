import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/notification/notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(false) bool isLoading,
    @Default(0) int count,
    @Default([]) List<Notification> notifications,
    @Default(false) bool isClearing,
    @Default(false) bool isTappedOnNotification,
    @Default(null) BaseException? error,
  }) = _NotificationState;
}
