import 'package:aaraadhya_temple_dashboard/data/models/booking/member/member.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booked_pooja_details.freezed.dart';
part 'booked_pooja_details.g.dart';

@freezed
class BookedPoojaDetails with _$BookedPoojaDetails {
  const factory BookedPoojaDetails({
    required String name,
    required String starSign,
    required List<Member> members,
    required PoojaSchedule schedule,
    required String poojaDate,
  }) = _BookedPoojaDetails;

  factory BookedPoojaDetails.fromJson(Map<String, dynamic> json) =>
      _$BookedPoojaDetailsFromJson(json);
}
