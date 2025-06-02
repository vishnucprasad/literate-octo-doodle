import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
class Member with _$Member {
  const factory Member({required String name, required String starSign}) =
      _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}
