import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_details.freezed.dart';
part 'bank_details.g.dart';

@freezed
class BankDetails with _$BankDetails {
  const factory BankDetails({
    String? bankName,
    String? accountHolderName,
    String? accountNumber,
    String? ifscCode,
    String? upiId,
  }) = _BankDetails;

  const BankDetails._();

  bool get isEmpty =>
      bankName == null ||
      bankName!.isEmpty ||
      accountHolderName == null ||
      accountHolderName!.isEmpty ||
      accountNumber == null ||
      accountNumber!.isEmpty ||
      ifscCode == null ||
      ifscCode!.isEmpty ||
      upiId == null ||
      upiId!.isEmpty;

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);
}
