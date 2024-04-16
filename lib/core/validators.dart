import 'package:email_validator/email_validator.dart';

class Validators {
  static String? commonTextValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field cannot be empty";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email cannot be empty";
    }

    bool isEmail = EmailValidator.validate(value);
    return isEmail ? null : "Enter a valid email";
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 6) {
      return "Enter at least 6 characters";
    } else {
      return null;
    }
  }

  static String? cPasswordValidator(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return "Confirm password cannot be empty";
    } else if (value != password) {
      return "Doesn't match with password";
    } else {
      return null;
    }
  }
}
