import 'package:aaraadhya_temple_dashboard/core/utils/validators.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/signin/signin_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signin_controller.g.dart';

@riverpod
class SigninController extends _$SigninController {
  @override
  SigninState build() {
    return SigninState();
  }

  void updateEmail(String email) {
    state = state.copyWith(
      credentials: state.credentials.copyWith(email: email),
      validationErrors: state.validationErrors.copyWith(
        email: Validators.validateEmail(email),
      ),
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      credentials: state.credentials.copyWith(password: password),
      validationErrors: state.validationErrors.copyWith(
        password: Validators.validatePassword(password),
      ),
    );
  }

  Future<dynamic> signin() async {
    if (!state.isValid) {
      return state = state.copyWith(
        validationErrors: state.validationErrors.copyWith(
          email: Validators.validateEmail(state.credentials.email),
          password: Validators.validatePassword(state.credentials.password),
          showValidationErrors: true,
        ),
      );
    }
  }
}
