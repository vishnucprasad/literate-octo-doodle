import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/data/models/devotee/devotee.dart';
import 'package:aaraadhya_temple_dashboard/data/models/payment/payment_details/payment_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String userId,
    required String price,
    required PaymentDetails paymentDetails,
    required BookingStatus status,
    required Devotee devotee,
    required DateTime createdAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
