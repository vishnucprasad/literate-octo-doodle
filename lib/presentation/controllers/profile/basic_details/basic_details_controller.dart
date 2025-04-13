import 'package:aaraadhya_temple_dashboard/core/enums/temple_managing_authority.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/time_range.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/profile_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_details_controller.g.dart';

@riverpod
class BasicDetailsController extends _$BasicDetailsController {
  @override
  BasicDetailsState build() {
    Future.microtask(loadBasicDetails);
    return BasicDetailsState();
  }

  void enableForm() => state = state.copyWith(isFormEnabled: true);

  void disableForm() => state = state.copyWith(isFormEnabled: false);

  Future<void> loadBasicDetails() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final basicDetails = await profileRepository.getBasicDetails(user.uid);
        if (basicDetails != null) {
          state = state.copyWith(basicDetails: basicDetails);
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

  Future<void> uploadProfilePicture() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isUploading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final imageUrl = await profileRepository.updateProfilePicture(
          user.uid,
          state.basicDetails,
        );

        state = state.copyWith(
          isUploading: false,
          basicDetails: state.basicDetails.copyWith(
            profilePictureUrl: imageUrl,
          ),
        );
      }

      state = state.copyWith(isUploading: false, error: null);
    } on BaseException catch (e) {
      state = state.copyWith(isUploading: false, error: e);
    } catch (e) {
      state = state.copyWith(
        isUploading: false,
        error: DatabaseException.unexpected(e.toString()),
      );
    }
  }

  void updateTempleName(String templeName) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(templeName: templeName),
      validationErrors: state.validationErrors.copyWith(
        templeName: Validators.validateName(templeName),
      ),
    );
  }

  void updateMainDeityName(String deityName) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(mainDeityName: deityName),
      validationErrors: state.validationErrors.copyWith(
        mainDeityName: Validators.validateName(deityName),
      ),
    );
  }

  void updateOtherDeities(String otherDeities) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(
        otherDeities: otherDeities.split(','),
      ),
      validationErrors: state.validationErrors.copyWith(
        otherDeities: Validators.validateRequired(otherDeities),
      ),
    );
  }

  void updateManagingAuthority(TempleManagingAuthority managingAuthority) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(
        managingAuthority: managingAuthority,
      ),
      validationErrors: state.validationErrors.copyWith(
        managingAuthority: Validators.validateRequired(managingAuthority.name),
      ),
    );
  }

  void updateMorningSchedule(TimeRange schedule) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(morningSchedule: schedule),
      validationErrors: state.validationErrors.copyWith(
        morningSchedule: Validators.validateNotNull(schedule),
      ),
    );
  }

  void updateEveningSchedule(TimeRange schedule) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(eveningSchedule: schedule),
      validationErrors: state.validationErrors.copyWith(
        eveningSchedule: Validators.validateNotNull(schedule),
      ),
    );
  }

  void updateTempleDescription(String description) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(description: description),
      validationErrors: state.validationErrors.copyWith(
        description: Validators.validateRequiredWithMinAndMaxLength(
          description,
          10,
          1000,
        ),
      ),
    );
  }

  void updateRules(String rules) {
    state = state.copyWith(
      basicDetails: state.basicDetails.copyWith(rules: rules),
      validationErrors: state.validationErrors.copyWith(
        rules: Validators.validateRequiredWithMinAndMaxLength(rules, 10, 1000),
      ),
    );
  }

  Future<dynamic> saveChanges() async {
    if (!state.isValid) {
      return state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          templeName: Validators.validateName(state.basicDetails.templeName),
          mainDeityName: Validators.validateName(
            state.basicDetails.mainDeityName,
          ),
          otherDeities: Validators.validateRequired(
            state.basicDetails.otherDeities?.join(','),
          ),
          managingAuthority: Validators.validateRequired(
            state.basicDetails.managingAuthority?.name,
          ),
          morningSchedule: Validators.validateNotNull(
            state.basicDetails.morningSchedule,
          ),
          eveningSchedule: Validators.validateNotNull(
            state.basicDetails.eveningSchedule,
          ),
          description: Validators.validateRequired(
            state.basicDetails.description,
          ),
          rules: Validators.validateRequired(state.basicDetails.rules),
          showValidationErrors: true,
        ),
      );
    }

    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isSaving: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        await profileRepository.saveBasicDetails(user.uid, state.basicDetails);
      }
      state = state.copyWith(
        isSaving: false,
        isFormEnabled: false,
        error: null,
      );
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
