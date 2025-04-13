import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/profile_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/advanced_options/advanced_options_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'advanced_options_controller.g.dart';

@riverpod
class AdvancedOptionsController extends _$AdvancedOptionsController {
  @override
  AdvancedOptionsState build() {
    Future.microtask(loadAdvancedOptions);
    return AdvancedOptionsState();
  }

  Future<void> loadAdvancedOptions() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        final advancedOptions = await profileRepository.getAdvancedOptions(
          user.uid,
        );
        if (advancedOptions != null) {
          state = state.copyWith(advancedOptions: advancedOptions);
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

  void updateSmsNotification(bool value) async {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        smsNotificationForDevotees: value,
      ),
    );

    await saveAdvancedOptions();
  }

  void updateEmailNotification(bool value) async {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        emailNotificationForDevotees: value,
      ),
    );

    await saveAdvancedOptions();
  }

  void updateOnlineBookingOption(bool value) async {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        enableOnlineBooking: value,
      ),
    );

    await saveAdvancedOptions();
  }

  void updateAdvancedBookingLimit(String limit) {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        advancedOnlneBookingLimit: limit,
      ),
      advancedBookingLimitValidationErorr: Validators.validateLimit(limit),
    );
  }

  Future<bool> saveAdvancedBookingLimit() async {
    if (state.advancedBookingLimitValidationErorr == null) {
      await saveAdvancedOptions();
      return true;
    }
    return false;
  }

  void updateBankName(String bankName) {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        bankDetails: state.advancedOptions.bankDetails.copyWith(
          bankName: bankName,
        ),
      ),
      validationErrors: state.validationErrors.copyWith(
        bankName: Validators.validateName(bankName),
      ),
    );
  }

  void updateAccountNumber(String accountNumber) {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        bankDetails: state.advancedOptions.bankDetails.copyWith(
          accountNumber: accountNumber,
        ),
      ),
      validationErrors: state.validationErrors.copyWith(
        accountNumber: Validators.validateBankAccountNumber(accountNumber),
      ),
    );
  }

  void updateIfscCode(String ifscCode) {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        bankDetails: state.advancedOptions.bankDetails.copyWith(
          ifscCode: ifscCode,
        ),
      ),
      validationErrors: state.validationErrors.copyWith(
        ifscCode: Validators.validateIFSCCode(ifscCode),
      ),
    );
  }

  void updateAccountHolderName(String accountHolderName) {
    state = state.copyWith(
      advancedOptions: state.advancedOptions.copyWith(
        bankDetails: state.advancedOptions.bankDetails.copyWith(
          accountHolderName: accountHolderName,
        ),
      ),
      validationErrors: state.validationErrors.copyWith(
        accountHolderName: Validators.validateName(accountHolderName),
      ),
    );
  }

  Future<dynamic> saveBankDetails() async {
    if (!state.isValid) {
      return state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          bankName: Validators.validateName(
            state.advancedOptions.bankDetails.bankName,
          ),
          accountNumber: Validators.validateBankAccountNumber(
            state.advancedOptions.bankDetails.accountNumber,
          ),
          ifscCode: Validators.validateIFSCCode(
            state.advancedOptions.bankDetails.ifscCode,
          ),
          accountHolderName: Validators.validateName(
            state.advancedOptions.bankDetails.accountHolderName,
          ),
        ),
      );
    }

    await saveAdvancedOptions();
  }

  Future<dynamic> saveAdvancedOptions() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final profileRepository = ref.watch(profileRepositoryProvider);

    try {
      state = state.copyWith(isSaving: true, error: null);

      final user = authRepository.getCurrentUser();

      if (user != null) {
        await profileRepository.saveAdvancedOptions(
          user.uid,
          state.advancedOptions,
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
