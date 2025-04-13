import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_contact_details/contact.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'temple_contact_details.freezed.dart';
part 'temple_contact_details.g.dart';

@freezed
class TempleContactDetails with _$TempleContactDetails {
  const factory TempleContactDetails({
    @Default(Contact()) Contact chiefPriest,
    @Default([Contact()]) List<Contact> committeeMembers,
    String? address,
    String? locationLink,
    String? websiteLink,
  }) = _TempleContactDetails;

  const TempleContactDetails._();

  bool get isEmpty =>
      chiefPriest.isEmpty ||
      committeeMembers.isEmpty ||
      address == null ||
      address!.isEmpty ||
      locationLink == null ||
      locationLink!.isEmpty;

  factory TempleContactDetails.fromJson(Map<String, dynamic> json) =>
      _$TempleContactDetailsFromJson(json);
}
