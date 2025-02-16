import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';

///Provides an interface to store values with encryption.
abstract class SecureStorage {
  ///Reads a value saved with [key] from storage
  Future<String?> read(String key);

  ///Writes [value] to storage with [key].
  Future<void> write({required String key, required String value});

  ///Deletes a value saved with [key] from storage
  Future<bool> delete(String key);
}

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl({FlutterSecureStorage? storage, required this.logger}) {
    _storage = storage ?? const FlutterSecureStorage();
  }

  late FlutterSecureStorage _storage;
  final Talker logger;

  static AndroidOptions get getAndroidOptions =>
      const AndroidOptions(encryptedSharedPreferences: true);

  static IOSOptions get getIosOptions =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      logger.error('SecureStorage: write error', e);
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      logger.error('SecureStorage: read error', e);
      return null;
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }
}
