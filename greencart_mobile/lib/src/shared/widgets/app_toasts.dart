import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:toastification/toastification.dart';

class AppToasts {
  static dynamic success(String message) {
    toastification.show(
      icon: const Icon(
        IconsaxPlusBold.tick_circle,
        color: AppColors.green500,
      ),
      title: Text(
        message,
        style: TextStyle(color: AppColors.green800),
      ),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.topCenter,
      borderSide: const BorderSide(color: AppColors.green50),
      backgroundColor: AppColors.green50,
      foregroundColor: AppColors.green500,
      borderRadius: BorderRadius.circular(6.0),
      closeOnClick: false,
      dragToClose: true,
      dismissDirection: DismissDirection.startToEnd,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }

  static dynamic error(String message) {
    toastification.show(
      icon: const Icon(
        IconsaxPlusBold.close_circle,
        color: AppColors.red500,
      ),
      title: Text(
        message,
        style: TextStyle(color: AppColors.red800),
      ),
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      alignment: Alignment.topCenter,
      borderSide: const BorderSide(color: AppColors.red50),
      backgroundColor: AppColors.red50,
      foregroundColor: AppColors.red500,
      borderRadius: BorderRadius.circular(6.0),
      closeOnClick: false,
      dragToClose: true,
      dismissDirection: DismissDirection.startToEnd,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.always,
    );
  }
}
