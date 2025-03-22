import 'package:freezed_annotation/freezed_annotation.dart';

part 'credentials.freezed.dart';

@freezed
abstract class Credentials with _$Credentials {
  const factory Credentials({
    @Default('') String email,
    @Default('') String password,
  }) = _Credentials;

  const Credentials._();

  bool get isEmpty => email.isEmpty || password.isEmpty;
}
