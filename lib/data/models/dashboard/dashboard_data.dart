import 'package:aaraadhya_temple_dashboard/data/models/booking/booking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';
part 'dashboard_data.g.dart';

@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    @Default(0.00) double totalPayments,
    @Default(0) int totalBookings,
    @Default(0) int totalActivePoojas,
    @Default(0) int totalActiveEvents,
    @Default([]) List<Booking> latestBookings,
    @Default([]) List<dynamic> latestNotifications,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}
