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

  static ValidationError? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (password.isEmpty) return ValidationError.empty();
    if (password != confirmPassword) return ValidationError.notMatched();

    return null;
  }

  static ValidationError? validateName(String? name) {
    if (name == null || name.isEmpty) return ValidationError.empty();

    final nameRegExp = RegExp(r'^[\u0D00-\u0D7F a-zA-Z]+$');

    if (!nameRegExp.hasMatch(name)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static ValidationError? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return ValidationError.empty();
    }

    final phoneRegExp = RegExp(r'^(\+?\d{1,4}[-\s]?)?\d{10}$');

    if (!phoneRegExp.hasMatch(phoneNumber)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static ValidationError? validateLink(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty();
    final urlRegExp = RegExp(
      r'^(?:http|https):\/\/[\w\-]+(?:\.[\w\-]+)+[\w\-.,@?^=%&:/~+#]*$',
    );
    if (!urlRegExp.hasMatch(value)) {
      return ValidationError.invalid();
    }
    return null;
  }

  static ValidationError? validateNullableLink(String? value) {
    if (value == null || value.isEmpty) return null;
    final urlRegExp = RegExp(
      r'^(?:http|https):\/\/[\w\-]+(?:\.[\w\-]+)+[\w\-.,@?^=%&:/~+#]*$',
    );
    if (!urlRegExp.hasMatch(value)) {
      return ValidationError.invalid();
    }
    return null;
  }

  static ValidationError? validateRequired(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty();
    return null;
  }

  static ValidationError? validateRequiredWithMinAndMaxLength(
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

  static ValidationError? validateNotNull(dynamic value) {
    if (value == null) return ValidationError.empty();
    return null;
  }

  static ValidationError? validateLimit(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty();

    final limitRegExp = RegExp(r'^\d{1,2}$');
    if (!limitRegExp.hasMatch(value)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static ValidationError? validateBankAccountNumber(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty();

    final accountNumberRegExp = RegExp(r'^\d{9,18}$');
    if (!accountNumberRegExp.hasMatch(value)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static ValidationError? validateIFSCCode(String? value) {
    if (value == null || value.isEmpty) return ValidationError.empty();

    final ifscCodeRegExp = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    if (!ifscCodeRegExp.hasMatch(value)) {
      return ValidationError.invalid();
    }

    return null;
  }

  static ValidationError? validateUpiId(String? value) {
    if (value == null || value.trim().isEmpty) return ValidationError.empty();

    final upiRegExp = RegExp(r'^[\w\.\-_]{2,256}@[a-zA-Z]{3,64}$');

    if (!upiRegExp.hasMatch(value)) {
      return ValidationError.invalid();
    }

    return null;
  }
}
