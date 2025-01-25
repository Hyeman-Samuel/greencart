import 'package:flutter/material.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle heading4;
  final TextStyle heading5;
  final TextStyle heading6;
  final TextStyle largeTextBold;
  final TextStyle largeTextRegular;
  final TextStyle mediumTextBold;
  final TextStyle mediumTextRegular;
  final TextStyle normalTextBold;
  final TextStyle normalTextRegular;
  final TextStyle smallTextBold;
  final TextStyle smallTextRegular;
  final TextStyle bottomNavBarIconText;
  final TextStyle buttonSmall;
  final TextStyle buttonLarge;

  const AppTextTheme._internal({
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.heading4,
    required this.heading5,
    required this.heading6,
    required this.largeTextBold,
    required this.largeTextRegular,
    required this.mediumTextBold,
    required this.mediumTextRegular,
    required this.normalTextBold,
    required this.normalTextRegular,
    required this.smallTextBold,
    required this.smallTextRegular,
    required this.bottomNavBarIconText,
    required this.buttonSmall,
    required this.buttonLarge,
  });

  factory AppTextTheme.main() => const AppTextTheme._internal(
        heading1: TextStyle(
          fontSize: 56,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        heading2: TextStyle(
          fontSize: 48,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        heading3: TextStyle(
          fontSize: 40,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        heading4: TextStyle(
          fontSize: 32,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        heading5: TextStyle(
          fontSize: 24,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        heading6: TextStyle(
          fontSize: 20,
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        largeTextBold: TextStyle(
          fontSize: 20,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        largeTextRegular: TextStyle(
          fontSize: 20,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
        mediumTextBold: TextStyle(
          fontSize: 18,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        mediumTextRegular: TextStyle(
          fontSize: 18,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
        normalTextBold: TextStyle(
          fontSize: 16,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        normalTextRegular: TextStyle(
          fontSize: 16,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
        smallTextBold: TextStyle(
          fontSize: 14,
          height: 1.2,
          fontWeight: FontWeight.w700,
        ),
        smallTextRegular: TextStyle(
          fontSize: 14,
          height: 1.2,
          fontWeight: FontWeight.w400,
        ),
        bottomNavBarIconText: TextStyle(
          fontSize: 10,
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        buttonSmall: TextStyle(
          fontSize: 10,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
        buttonLarge: TextStyle(
          fontSize: 16,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
      );

  @override
  ThemeExtension<AppTextTheme> copyWith() {
    return AppTextTheme._internal(
      heading1: heading1,
      heading2: heading2,
      heading3: heading3,
      heading4: heading4,
      heading5: heading5,
      heading6: heading6,
      largeTextBold: largeTextBold,
      largeTextRegular: largeTextRegular,
      mediumTextBold: mediumTextBold,
      mediumTextRegular: mediumTextRegular,
      normalTextBold: normalTextBold,
      normalTextRegular: normalTextRegular,
      smallTextBold: smallTextBold,
      smallTextRegular: smallTextRegular,
      bottomNavBarIconText: bottomNavBarIconText,
      buttonSmall: buttonSmall,
      buttonLarge: buttonLarge,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
          covariant ThemeExtension<AppTextTheme>? other, double t) =>
      this;

  @override
  bool operator ==(covariant AppTextTheme other) {
    if (identical(this, other)) {
      return true;
    }

    return other.heading1 == heading1 &&
        other.heading2 == heading2 &&
        other.heading3 == heading3 &&
        other.heading4 == heading4 &&
        other.heading5 == heading5 &&
        other.heading6 == heading6 &&
        other.largeTextBold == largeTextBold &&
        other.largeTextRegular == largeTextRegular &&
        other.mediumTextBold == mediumTextBold &&
        other.mediumTextRegular == mediumTextRegular &&
        other.normalTextBold == normalTextBold &&
        other.normalTextRegular == normalTextRegular &&
        other.smallTextBold == smallTextBold &&
        other.smallTextRegular == smallTextRegular &&
        other.bottomNavBarIconText == bottomNavBarIconText &&
        other.buttonSmall == buttonSmall &&
        other.buttonLarge == buttonLarge;
  }

  @override
  int get hashCode {
    return heading1.hashCode ^
        heading2.hashCode ^
        heading3.hashCode ^
        heading4.hashCode ^
        heading5.hashCode ^
        heading6.hashCode ^
        largeTextBold.hashCode ^
        largeTextRegular.hashCode ^
        mediumTextBold.hashCode ^
        mediumTextRegular.hashCode ^
        normalTextBold.hashCode ^
        normalTextRegular.hashCode ^
        smallTextBold.hashCode ^
        smallTextRegular.hashCode ^
        bottomNavBarIconText.hashCode ^
        buttonSmall.hashCode ^
        buttonLarge.hashCode;
  }
}
