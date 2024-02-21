import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class CacheHelper {
  Future<String?> getString(String key);

  void putString(String key, String value);

  void delete(String key);
}

class SecureCacheHelper implements CacheHelper {
  final FlutterSecureStorage _flutterSecureStorage;

  SecureCacheHelper() : _flutterSecureStorage = const FlutterSecureStorage();

  @override
  void delete(String key) => _flutterSecureStorage.delete(key: key);

  @override
  Future<String?> getString(String key) async =>
      await _flutterSecureStorage.read(key: key);

  @override
  void putString(String key, value) =>
      _flutterSecureStorage.write(key: key, value: value);
}