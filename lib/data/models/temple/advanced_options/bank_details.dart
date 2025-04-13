import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_details.freezed.dart';
part 'bank_details.g.dart';

@freezed
class BankDetails with _$BankDetails {
  const factory BankDetails({
    String? bankName,
    String? accountNumber,
    String? ifscCode,
    String? accountHolderName,
  }) = _BankDetails;

  const BankDetails._();

  bool get isEmpty =>
      bankName == null ||
      bankName!.isEmpty ||
      accountNumber == null ||
      accountNumber!.isEmpty ||
      ifscCode == null ||
      ifscCode!.isEmpty ||
      accountHolderName == null ||
      accountHolderName!.isEmpty;

  factory BankDetails.fromJson(Map<String, dynamic> json) =>
      _$BankDetailsFromJson(json);
}
