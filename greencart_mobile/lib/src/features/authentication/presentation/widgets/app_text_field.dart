import 'package:flutter/material.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.textFieldKey,
    required this.formControlName,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.validationMessages,
    this.showVisibilityIcon = false,
  });

  const AppTextField.secret({
    super.key,
    this.textFieldKey,
    this.formControlName,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.validationMessages,
    this.hintText,
    this.showVisibilityIcon = true,
  });

  final Key? textFieldKey;
  final String? formControlName;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(FormControl<Object?>)? onSubmitted;
  final Map<String, String Function(Object)>? validationMessages;
  final String? hintText;
  final bool? showVisibilityIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      key: widget.textFieldKey,
      formControlName: widget.formControlName,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.showVisibilityIcon == true ? hideText : false,
      onSubmitted: widget.onSubmitted,
      validationMessages: widget.validationMessages,
      cursorColor: AppColors.white,
      style: const TextStyle(
        fontSize: 17,
        color: AppColors.white,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: Sizes.p12.allPadding,
        filled: true,
        fillColor: AppColors.white.withAlpha(102),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 17,
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.red400,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon:
            widget.showVisibilityIcon == true
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      hideText = !hideText;
                    });
                  },
                  splashColor: Colors.transparent,
                  icon:
                      hideText
                          ? const Icon(
                            IconsaxPlusLinear.eye,
                            color: AppColors.white,
                            size: 18,
                          )
                          : const Icon(
                            IconsaxPlusLinear.eye_slash,
                            color: AppColors.white,
                            size: 18,
                          ),
                )
                : null,
      ),
    );
  }
}
