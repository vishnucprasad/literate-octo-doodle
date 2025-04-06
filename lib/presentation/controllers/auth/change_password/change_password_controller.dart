import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/change_password/change_password_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_controller.g.dart';

@riverpod
class ChangePasswordController extends _$ChangePasswordController {
  @override
  ChangePasswordState build() {
    return ChangePasswordState();
  }

  void updateCurrentPassword(String currentPassword) {
    state = state.copyWith(
      currentPassword: currentPassword,
      currentPasswordValidationError: Validators.validatePassword(
        currentPassword,
      ),
    );
  }

  void updateNewPassword(String newPassword) {
    state = state.copyWith(
      newPassword: newPassword,
      newPasswordValidationError: Validators.validatePassword(newPassword),
    );
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      confirmPasswordValidationError: Validators.validateConfirmPassword(
        state.newPassword,
        confirmPassword,
      ),
    );
  }

  Future<dynamic> changePassword() async {
    if (!state.isValid) {
      return state = state.copyWith(
        currentPasswordValidationError: Validators.validatePassword(
          state.currentPassword,
        ),
        newPasswordValidationError: Validators.validatePassword(
          state.newPassword,
        ),
        confirmPasswordValidationError: Validators.validateConfirmPassword(
          state.newPassword,
          state.confirmPassword,
        ),
        showValidationErrors: true,
      );
    }

    final authRepository = ref.read(authRepositoryProvider);

    try {
      state = state.copyWith(isChanging: true);
      await authRepository.changePassword(
        state.currentPassword,
        state.newPassword,
      );
    } on BaseException catch (e) {
      state = state.copyWith(error: e);
    } catch (e) {
      state = state.copyWith(error: AuthException.unexpected(e.toString()));
    } finally {
      state = state.copyWith(isChanging: false);
    }
  }
}
