import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final Color? backgroundDefault;
  final Color? splashBackgroundColor;

  const AppColorTheme._internal({
    required this.backgroundDefault,
    required this.splashBackgroundColor,
  });

  factory AppColorTheme.light() {
    return const AppColorTheme._internal(
      backgroundDefault: AppColors.white,
      splashBackgroundColor: AppColors.white,
    );
  }
  factory AppColorTheme.dark() {
    return const AppColorTheme._internal(
      backgroundDefault: AppColors.white,
      splashBackgroundColor: AppColors.splashDarkBackground,
    );
  }

  @override
  ThemeExtension<AppColorTheme> lerp(
      covariant ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) {
      return this;
    }
    return AppColorTheme._internal(
      backgroundDefault:
          Color.lerp(backgroundDefault, other.backgroundDefault, t),
      splashBackgroundColor:
          Color.lerp(splashBackgroundColor, other.splashBackgroundColor, t),
    );
  }

  @override
  AppColorTheme copyWith({
    Color? backgroundDefault,
    Color? splashBackgroundColor,
  }) {
    return AppColorTheme._internal(
      backgroundDefault: backgroundDefault ?? this.backgroundDefault,
      splashBackgroundColor:
          splashBackgroundColor ?? this.splashBackgroundColor,
    );
  }

  @override
  bool operator ==(covariant AppColorTheme other) {
    if (identical(this, other)) {
      return true;
    }

    return other.backgroundDefault == backgroundDefault &&
        other.splashBackgroundColor == splashBackgroundColor;
  }

  @override
  int get hashCode =>
      backgroundDefault.hashCode ^ splashBackgroundColor.hashCode;
}
