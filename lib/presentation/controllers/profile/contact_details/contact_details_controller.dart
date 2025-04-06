import 'dart:developer';

import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_contact_details/contact.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/validation_errors/contact_validation_errors.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/profile_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/contact_details/contact_details_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_details_controller.g.dart';

@riverpod
class ContactDetailsController extends _$ContactDetailsController {
  @override
  ContactDetailsState build() {
    Future.microtask(loadContactDetails);
    return ContactDetailsState();
  }

  Future<void> loadContactDetails() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final contactDetails = await profileRepository.getContactDetails(
          user.uid,
        );

        if (contactDetails != null) {
          state = state.copyWith(
            contactDetails: contactDetails,
            validationErrors: state.validationErrors.copyWith(
              committeeMembers: List.generate(
                contactDetails.committeeMembers.length,
                (index) => ContactValidationErrors(),
              ),
            ),
          );
        }
      }

      state = state.copyWith(isLoading: false, error: null);
    } on BaseException catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }

  void addNewCommitteeMember() {
    final lastContact = state.contactDetails.committeeMembers.last;
    if (lastContact.name.isNotEmpty && lastContact.phoneNumber.isNotEmpty) {
      state = state.copyWith(
        contactDetails: state.contactDetails.copyWith(
          committeeMembers: [
            ...state.contactDetails.committeeMembers,
            Contact(),
          ],
        ),
        validationErrors: state.validationErrors.copyWith(
          committeeMembers: [
            ...state.validationErrors.committeeMembers,
            ContactValidationErrors(),
          ],
        ),
      );
    }
  }

  void updateCommitteeMemberName(String name, {required int index}) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(
        committeeMembers:
            state.contactDetails.committeeMembers.asMap().entries.map((entry) {
              if (entry.key == index) {
                return entry.value.copyWith(name: name);
              }
              return entry.value;
            }).toList(),
      ),
      validationErrors: state.validationErrors.copyWith(
        committeeMembers:
            state.validationErrors.committeeMembers.asMap().entries.map((
              entry,
            ) {
              if (entry.key == index) {
                return entry.value.copyWith(
                  name: Validators.validateName(name),
                );
              }
              return entry.value;
            }).toList(),
      ),
    );

    log(state.contactDetails.committeeMembers.toString());
  }

  void updateCommitteeMemberNumber(String number, {required int index}) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(
        committeeMembers:
            state.contactDetails.committeeMembers.asMap().entries.map((entry) {
              if (entry.key == index) {
                return entry.value.copyWith(phoneNumber: number);
              }
              return entry.value;
            }).toList(),
      ),
      validationErrors: state.validationErrors.copyWith(
        committeeMembers:
            state.validationErrors.committeeMembers.asMap().entries.map((
              entry,
            ) {
              if (entry.key == index) {
                return entry.value.copyWith(
                  phoneNumber: Validators.validatePhoneNumber(number),
                );
              }
              return entry.value;
            }).toList(),
      ),
    );

    log(state.contactDetails.committeeMembers.toString());
  }

  void updateCheifPriestName(String name) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(
        chiefPriest: state.contactDetails.chiefPriest.copyWith(name: name),
      ),
      validationErrors: state.validationErrors.copyWith(
        chiefPriest: state.validationErrors.chiefPriest.copyWith(
          name: Validators.validateName(name),
        ),
      ),
    );
  }

  void updateCheifPriestNumber(String number) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(
        chiefPriest: state.contactDetails.chiefPriest.copyWith(
          phoneNumber: number,
        ),
      ),
      validationErrors: state.validationErrors.copyWith(
        chiefPriest: state.validationErrors.chiefPriest.copyWith(
          phoneNumber: Validators.validatePhoneNumber(number),
        ),
      ),
    );
  }

  void updateAddress(String address) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(address: address),
      validationErrors: state.validationErrors.copyWith(
        address: Validators.validateRequired(address),
      ),
    );
  }

  void updateLocationLink(String link) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(locationLink: link),
      validationErrors: state.validationErrors.copyWith(
        locationLink: Validators.validateLink(link),
      ),
    );
  }

  void updateWebsiteLink(String link) {
    state = state.copyWith(
      contactDetails: state.contactDetails.copyWith(websiteLink: link),
      validationErrors: state.validationErrors.copyWith(
        websiteLink: Validators.validateNullableLink(link),
      ),
    );
  }

  Future<dynamic> saveChanges() async {
    if (!state.isValid) {
      return state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          chiefPriest: state.validationErrors.chiefPriest.copyWith(
            name: Validators.validateName(
              state.contactDetails.chiefPriest.name,
            ),
            phoneNumber: Validators.validatePhoneNumber(
              state.contactDetails.chiefPriest.phoneNumber,
            ),
          ),
          committeeMembers:
              state.contactDetails.committeeMembers
                  .asMap()
                  .entries
                  .map(
                    (entry) => ContactValidationErrors(
                      name: Validators.validateName(entry.value.name),
                      phoneNumber: Validators.validatePhoneNumber(
                        entry.value.phoneNumber,
                      ),
                    ),
                  )
                  .toList(),
          address: Validators.validateRequired(state.contactDetails.address),
          locationLink: Validators.validateLink(
            state.contactDetails.locationLink,
          ),
          websiteLink: Validators.validateNullableLink(
            state.contactDetails.websiteLink,
          ),
        ),
      );
    }

    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isSaving: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        await profileRepository.saveContactDetails(
          user.uid,
          state.contactDetails,
        );
      }
      state = state.copyWith(isSaving: false, error: null);
    } on BaseException catch (e) {
      state = state.copyWith(isSaving: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }
}
