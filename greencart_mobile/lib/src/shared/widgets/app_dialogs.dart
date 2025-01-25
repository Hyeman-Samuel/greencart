import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/shared/shared.dart';

class AppDialogs {
  static Future<bool?> showAlertDialog({
    required BuildContext context,
    required String? title,
    String? content,
    String? cancelActionText,
    String defaultActionText = 'OK',
    VoidCallback? onDefaultAction,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog.adaptive(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(title ?? 'An Error Occurred'),
        content: content != null ? Text(content) : null,
        actions: kIsWeb || !Platform.isIOS
            ? <Widget>[
                if (cancelActionText != null)
                  InkWell(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text(cancelActionText),
                  ),
                Sizes.p4.hGap,
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(60, 32),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onDefaultAction?.call();
                  },
                  child: Text(defaultActionText),
                ),
              ]
            : <Widget>[
                if (cancelActionText != null)
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(cancelActionText),
                  ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onDefaultAction?.call();
                  },
                  child: Text(defaultActionText),
                ),
              ],
      ),
    );
  }

  static Future<void> showLoadingDialog({
    required BuildContext context,
    String? title,
    String? content,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
