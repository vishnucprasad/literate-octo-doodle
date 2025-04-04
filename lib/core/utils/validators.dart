import 'package:aaraadhya_temple_dashboard/data/models/common/validation_error.dart';

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

  static ValidationError? validateName(String? name) {
    if (name == null || name.isEmpty) return ValidationError.empty();

    final nameRegExp = RegExp(r'^[a-zA-Z ]+$');

    if (!nameRegExp.hasMatch(name)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static validateRequired(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty();
    return null;
  }

  static validateRequiredWithMinAndMaxLength(
    String? value,
    int minLength,
    int maxLength,
  ) {
    if (value == null || value.isEmpty) return ValidationError.empty();
    if (value.length < minLength) return ValidationError.short(minLength);
    if (value.length > maxLength) {
      return ValidationError.exceedingLength(maxLength);
    }
    return null;
  }

  static validateNotNull(dynamic value) {
    if (value == null) return ValidationError.empty();
    return null;
  }
}
