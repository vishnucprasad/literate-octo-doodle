import 'package:aaraadhya_temple_dashboard/core/enums/temple_managing_authority.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/time_range.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'temple_basic_details.freezed.dart';
part 'temple_basic_details.g.dart';

@freezed
class TempleBasicDetails with _$TempleBasicDetails {
  const factory TempleBasicDetails({
    String? profilePictureUrl,
    String? templeName,
    String? mainDeityName,
    List<String>? otherDeities,
    TempleManagingAuthority? managingAuthority,
    TimeRange? morningSchedule,
    TimeRange? eveningSchedule,
    List<String>? amenities,
    String? description,
    String? rules,
  }) = _TempleBasicDetails;

  const TempleBasicDetails._();

  bool get isEmpty =>
      templeName == null ||
      templeName!.isEmpty ||
      mainDeityName == null ||
      mainDeityName!.isEmpty ||
      otherDeities == null ||
      otherDeities!.isEmpty ||
      managingAuthority == null ||
      managingAuthority!.name.isEmpty ||
      morningSchedule == null ||
      eveningSchedule == null ||
      amenities == null ||
      amenities!.isEmpty ||
      description == null ||
      description!.isEmpty ||
      rules == null ||
      rules!.isEmpty;

  factory TempleBasicDetails.fromJson(Map<String, dynamic> json) =>
      _$TempleBasicDetailsFromJson(json);
}
