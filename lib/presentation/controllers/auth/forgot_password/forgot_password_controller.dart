import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
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

    return true;
  }
}
