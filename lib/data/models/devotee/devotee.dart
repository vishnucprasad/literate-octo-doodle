import 'package:freezed_annotation/freezed_annotation.dart';

part 'devotee.freezed.dart';
part 'devotee.g.dart';

@freezed
class Devotee with _$Devotee {
  const factory Devotee({
    required String uid,
    required String displayName,
    required String email,
    required String? photoURL,
    required bool isEmailVerified,
    required String providerId,
  }) = _Devotee;

  factory Devotee.fromJson(Map<String, dynamic> json) =>
      _$DevoteeFromJson(json);
}
