import 'package:aaraadhya_temple_dashboard/data/models/auth/validation_errors/validation_error.dart';

class Validators {
  Validators._();

  static ValidationError? validateEmail(String email) {
    if (email.isEmpty) return ValidationError.empty();

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(email)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static ValidationError? validatePassword(String password) {
    if (password.isEmpty) return ValidationError.empty();

    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\W_]{8,}$');

    if (!passwordRegExp.hasMatch(password)) {
      return ValidationError.invalid();
    }

    return null;
  }
}
