import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_contact_details/temple_contact_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/validation_errors/contact_details_validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_details_state.freezed.dart';

@freezed
class ContactDetailsState with _$ContactDetailsState {
  const factory ContactDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(TempleContactDetails()) TempleContactDetails contactDetails,
    @Default(ContactDetailsValidationErrors())
    ContactDetailsValidationErrors validationErrors,
    @Default(null) BaseException? error,
  }) = _ContactDetailsState;

  const ContactDetailsState._();

  bool get isValid =>
      !validationErrors.hasErrors && !contactDetails.isEmpty && !isSaving;
}
