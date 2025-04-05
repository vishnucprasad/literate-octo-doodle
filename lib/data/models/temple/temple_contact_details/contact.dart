import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';
part 'contact.g.dart';

@freezed
class Contact with _$Contact {
  const factory Contact({
    @Default('') String name,
    @Default('') String phoneNumber,
  }) = _Contact;

  const Contact._();

  bool get isEmpty => name.isEmpty || phoneNumber.isEmpty;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
}
