import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';

/// Configuration class which collects all Themes of app together and provides
/// them as a single instance
class AppTheme extends ThemeExtension<AppTheme> {
  final AppColorTheme appColorTheme;
  final AppTextTheme appTextTheme;

  const AppTheme._internal({
    required this.appColorTheme,
    required this.appTextTheme,
  });

  factory AppTheme.light() {
    return AppTheme._internal(
      appColorTheme: AppColorTheme.light(),
      appTextTheme: AppTextTheme.main(),
    );
  }

  factory AppTheme.dark() {
    return AppTheme._internal(
      appColorTheme: AppColorTheme.dark(),
      appTextTheme: AppTextTheme.main(),
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) {
      return this;
    }

    return AppTheme._internal(
      appColorTheme:
          appColorTheme.lerp(other.appColorTheme, t) as AppColorTheme,
      appTextTheme: appTextTheme.lerp(other.appTextTheme, t) as AppTextTheme,
    );
  }

  @override
  AppTheme copyWith({
    AppColorTheme? appColorTheme,
    AppTextTheme? appTextTheme,
  }) {
    return AppTheme._internal(
      appColorTheme: appColorTheme ?? this.appColorTheme,
      appTextTheme: appTextTheme ?? this.appTextTheme,
    );
  }

  @override
  bool operator ==(covariant AppTheme other) {
    if (identical(this, other)) {
      return true;
    }

    return other.appColorTheme == appColorTheme &&
        other.appTextTheme == appTextTheme;
  }

  @override
  int get hashCode => appColorTheme.hashCode ^ appTextTheme.hashCode;
}
