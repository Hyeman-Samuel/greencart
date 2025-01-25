import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/shared/shared.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  Size get mediaQuerySize => MediaQuery.sizeOf(this);
  AppTextTheme get appTextTheme => theme.extension<AppTheme>()!.appTextTheme;
  AppColorTheme get appColorTheme => theme.extension<AppTheme>()!.appColorTheme;
}

/// A simple placeholder that can be used to search all the hardcoded strings
/// in the code (useful to identify strings that need to be localized).
extension StringHardcoded on String {
  String get hardcoded => this;
}

extension AsyncValueUI on AsyncValue<dynamic> {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      AppDialogs.showAlertDialog(
        context: context,
        title: 'An Error Occurred',
        content: error.toString(),
      );
    }
  }

  void showLoadingDialog(BuildContext context) {
    if (isReloading || isLoading) {
      AppDialogs.showLoadingDialog(context: context);
    }
  }
}
