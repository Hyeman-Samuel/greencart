import 'dart:convert';
import 'package:greencart_app/src/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

abstract class LocalCache {
  ///Retrieves access token for authorizing requests
  Future<String> getToken();

  ///Saves access token for authorizing requests
  Future<void> saveToken(String tokenId);

  ///Deletes cached access token
  Future<void> deleteToken();

  ///Saves `value` to cache using `key`
  Future<void> saveToCache({required String key, required dynamic value});

  ///Retrieves a cached value stored with `key`
  T? getFromCache<T>(
    String key, [
    T Function(dynamic)? parser,
  ]);

  ///Removes cached value stored with `key` from cache
  Future<void> removeFromCache(String key);
}

class LocalCacheImpl implements LocalCache {
  LocalCacheImpl({
    required SecureStorage storage,
    required SharedPreferencesWithCache sharedPreferences,
    required this.logger,
  }) {
    _storage = storage;
    _sharedPreferences = sharedPreferences;
  }

  late SecureStorage _storage;
  late SharedPreferencesWithCache _sharedPreferences;
  final Talker logger;

  @override
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: LocalCacheKeys.userTokenKey, value: token);
    } catch (e) {
      logger.error('LocalCache: saveToken error', e);
    }
  }

  @override
  Future<String> getToken() async {
    return (await _storage.read(LocalCacheKeys.userTokenKey)) ?? "";
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _storage.delete(LocalCacheKeys.userTokenKey);
    } catch (e) {
      logger.error('LocalCache: deleteToken error', e);
    }
  }

  @override
  Future<void> saveToCache({required String key, required value}) async {
    switch (value) {
      case final String value:
        await _sharedPreferences.setString(key, value);
        break;
      case final bool value:
        await _sharedPreferences.setBool(key, value);
        break;
      case final int value:
        await _sharedPreferences.setInt(key, value);
        break;
      case final double value:
        await _sharedPreferences.setDouble(key, value);
        break;
      case final List<String> value:
        await _sharedPreferences.setStringList(key, value);
        break;
      case final Map<String, dynamic> value:
        await _sharedPreferences.setString(key, json.encode(value));
        break;
      default:
        logger
            .error('LocalCache: Attempted to save unknown type to local cache');
        break;
    }
  }

  @override
  T? getFromCache<T>(
    String key, [
    T Function(dynamic)? parser,
  ]) {
    try {
      T? value;
      switch (T) {
        case const (String):
          value = _sharedPreferences.getString(key) as T?;
        case const (int):
          value = _sharedPreferences.getInt(key) as T?;
        case const (double):
          value = _sharedPreferences.getDouble(key) as T?;
        case const (bool):
          value = _sharedPreferences.getBool(key) as T?;
        case const (List):
          value = _sharedPreferences.getStringList(key) as T?;
        case const (Map<String, dynamic>):
          value = json.decode(_sharedPreferences.getString(key) ?? '') as T?;
        default:
          value = _sharedPreferences.get(key) as T?;
      }
      if (parser != null) {
        return parser(value);
      }
      return value;
    } catch (e) {
      logger.error('LocalCache: getFromCache error', e);
      return null;
    }
  }

  @override
  Future<void> removeFromCache(String key) async {
    await _sharedPreferences.remove(key);
  }
}
