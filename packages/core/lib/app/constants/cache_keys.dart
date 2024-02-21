import 'package:flutter/foundation.dart' show immutable;

@immutable
class CacheKeys {
  const CacheKeys._();

  static const String locale = "locale";

  static const String theme = "theme";

  static const String language = "language";

  static const String encryption = "encryption";
}