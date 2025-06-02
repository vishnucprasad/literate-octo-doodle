import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_details.g.dart';
part 'payment_details.freezed.dart';

@freezed
class PaymentDetails with _$PaymentDetails {
  const factory PaymentDetails({
    required String paymentMethod,
    required String screenshotUrl,
  }) = _PaymentDetails;

  factory PaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailsFromJson(json);
}
