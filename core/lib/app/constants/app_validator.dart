import 'package:core/app/constants/app_constants.dart';

class AppValidator {
  static bool isEmail(String? email) {
    if (email == null || email.isEmpty || email.length < 11) {
      return false;
    }
    final exp = RegExp(AppConstants.emailPattern);
    return exp.hasMatch(email);
  }

  static bool isPassword(String? password) {
    if (password == null || password.isEmpty || password.length < 8) {
      return false;
    }
    final exp = RegExp(AppConstants.passwordPatternNumeric);
    return exp.hasMatch(password);
  }
}
