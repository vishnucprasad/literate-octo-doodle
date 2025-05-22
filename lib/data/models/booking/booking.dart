import 'package:aaraadhya_temple_dashboard/data/models/booking/booked_pooja_details/booked_pooja_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    required String id,
    required String userId,
    required BookedPoojaDetails pooja,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}
