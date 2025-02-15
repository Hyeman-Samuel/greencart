import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelColor,
    this.buttonColor,
    required this.width,
    required this.height,
  });

  const AppButton.large({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelColor,
    this.buttonColor,
    this.width = double.infinity,
    this.height = 48,
  });
  const AppButton.medium({
    super.key,
    required this.onPressed,
    required this.label,
    this.labelColor,
    this.buttonColor,
    this.width = 172,
    this.height = 48,
  });

  final VoidCallback? onPressed;
  final String label;
  final Color? labelColor;
  final Color? buttonColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? AppColors.white,
          disabledBackgroundColor: AppColors.gray4,
        ),
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: TextStyle(
            color: labelColor ?? AppColors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    /* GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor ?? AppColors.white,
        ),
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: TextStyle(
            color: labelColor ?? AppColors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ); */
  }
}
