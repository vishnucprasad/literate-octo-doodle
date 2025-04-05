import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/validation_errors/contact_validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_details_validation_errors.freezed.dart';

@freezed
abstract class ContactDetailsValidationErrors
    with _$ContactDetailsValidationErrors {
  const factory ContactDetailsValidationErrors({
    @Default(false) bool showValidationErrors,
    @Default(ContactValidationErrors()) ContactValidationErrors chiefPriest,
    @Default([ContactValidationErrors()])
    List<ContactValidationErrors> committeeMembers,
    ValidationError? address,
    ValidationError? locationLink,
    ValidationError? websiteLink,
  }) = _ContactDetailsValidationErrors;

  const ContactDetailsValidationErrors._();

  bool get hasErrors =>
      chiefPriest.hasErrors ||
      committeeMembers.isEmpty ||
      committeeMembers.any((element) => element.hasErrors) ||
      address != null ||
      locationLink != null ||
      websiteLink != null;
}
