import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'provider_registry.g.dart';

Talker talkerFlutter = TalkerFlutter.init(
  settings: TalkerSettings(
    useConsoleLogs: !kReleaseMode,
    enabled: !kReleaseMode,
    colors: {
      TalkerLogType.httpResponse.key: AnsiPen()..green(),
      TalkerLogType.route.key: AnsiPen()..cyan(),
      TalkerLogType.error.key: AnsiPen()..red(),
      TalkerLogType.debug.key: AnsiPen()..yellow(),
      TalkerLogType.info.key:
          AnsiPen()..rgb(r: 100 / 255, g: 181 / 255, b: 246 / 255),
      TalkerLogType.riverpodAdd.key:
          AnsiPen()..rgb(r: 76 / 255, g: 175 / 255, b: 80 / 255),
      TalkerLogType.riverpodUpdate.key:
          AnsiPen()..rgb(r: 33 / 255, g: 150 / 255, b: 243 / 255),
      TalkerLogType.riverpodFail.key:
          AnsiPen()..rgb(r: 244 / 255, g: 67 / 255, b: 54 / 255),
      TalkerLogType.riverpodDispose.key:
          AnsiPen()..rgb(r: 255 / 255, g: 152 / 255, b: 0 / 255),
    },
  ),
);

/// Use this to handle all logging in the app
@Riverpod(keepAlive: true)
Talker talkerLogger(Ref ref) => talkerFlutter;

@Riverpod(keepAlive: true)
Future<SharedPreferencesWithCache> sharedPreferences(Ref ref) {
  return SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );
}

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(Ref ref) {
  return PackageInfo.fromPlatform();
}

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) {
  return FlutterSecureStorage(
    aOptions: SecureStorageImpl.getAndroidOptions,
    iOptions: SecureStorageImpl.getIosOptions,
  );
}

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.onDispose(() {
    ref.invalidate(packageInfoProvider);
  });
  // all asynchronous app initialization code should belong here:
  await ref.watch(packageInfoProvider.future);
}

@riverpod
SecureStorage secureStorage(Ref ref) {
  final secureStorage = ref.watch(flutterSecureStorageProvider);
  final logger = ref.watch(talkerLoggerProvider);
  return SecureStorageImpl(storage: secureStorage, logger: logger);
}

@riverpod
LocalCache localCache(Ref ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final sharedPrefs = ref.watch(sharedPreferencesProvider).requireValue;
  final logger = ref.watch(talkerLoggerProvider);
  return LocalCacheImpl(
    storage: secureStorage,
    sharedPreferences: sharedPrefs,
    logger: logger,
  );
}
