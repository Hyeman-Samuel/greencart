import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';

class AppThemeData {
  final AppTheme appTheme;

  AppThemeData(this.appTheme);

  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        colorSchemeSeed: AppColors.primary,
        scaffoldBackgroundColor: appTheme.appColorTheme.backgroundDefault,
        extensions: [appTheme],
        textTheme: TextTheme(labelLarge: appTheme.appTextTheme.heading1),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: appTheme.appColorTheme.backgroundDefault,
          elevation: 0,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: appTheme.appColorTheme.backgroundDefault,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.primary,
        ),
      );
}
