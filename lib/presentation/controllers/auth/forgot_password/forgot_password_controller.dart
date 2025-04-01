import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/forgot_password/forgot_password_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_password_controller.g.dart';

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  ForgotPasswordState build() {
    return ForgotPasswordState();
  }

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      validationErrors: state.validationErrors.copyWith(
        email: Validators.validateEmail(email),
      ),
    );
  }

  Future<bool> resetPassword() async {
    if (!state.isValid) {
      state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          email: Validators.validateEmail(state.email),
          showValidationErrors: true,
        ),
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true, error: null);

    final authRepository = ref.read(authRepositoryProvider);

    try {
      await authRepository.sendPasswordResetEmail(state.email);
      state = state.copyWith(isSubmitting: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(isSubmitting: false, error: e);
      return false;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: AuthException.unexpected(e.toString()),
      );
      return false;
    }
  }
}
