import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_mode_controller.g.dart';

/// A controller used to read and write the themeMode to SharedPreferences
@riverpod
class AppThemeModeController extends _$AppThemeModeController {
  late LocalCache _localCache;
  @override
  ThemeMode build() {
    _localCache = ref.watch(localCacheProvider);

    final themeModeStr = _localCache.getFromCache(LocalCacheKeys.themeModeKey);

    return switch (themeModeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' || _ => ThemeMode.system,
    };
  }

  void setThemeMode(ThemeMode mode) {
    _localCache.saveToCache(key: LocalCacheKeys.themeModeKey, value: mode.name);
    ref.invalidateSelf();
  }
}
