import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppConstants {
  static const String emailPattern =
      r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";

  //Registration (1 upper case, 1 lower case, 1 special character) length = 8
  static const String passwordPatternSpecial =
      r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$";

  //Registration (1 upper case, 1 lower case, 1 number) length = 8
  static const String passwordPatternNumeric =
      r"(?=^.{8,}$)(?=.*\\d)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$";

  static const String searchApi =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static const String detailsApi =
      'https://maps.googleapis.com/maps/api/place/details/json';
}
