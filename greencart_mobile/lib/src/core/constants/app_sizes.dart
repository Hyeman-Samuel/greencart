import 'package:flutter/material.dart';

/// Example:
/// ```
/// return Column(
///   children: [
///     Padding(
///       padding: Sizes.p12.horizontal + Sizes.p12.vertical,
///       child: const Placeholder(),
///     ),
///     Sizes.p12.verticalGap,
///     const Placeholder(),
///   ],
/// );
enum Sizes {
  p0(0.0),
  p2(2.0),
  p4(4.0),
  p8(8.0),
  p12(12.0),
  p14(14.0),
  p16(16.0),
  p20(20.0),
  p24(24.0),
  p32(32.0),
  p40(40.0),
  p48(48.0),
  p64(64.0);

  const Sizes(this.value);
  final double value;

  EdgeInsets get allPadding => EdgeInsets.all(value);
  EdgeInsets get hPadding => EdgeInsets.symmetric(horizontal: value);
  EdgeInsets get vPadding => EdgeInsets.symmetric(vertical: value);

  EdgeInsets get tPadding => EdgeInsets.only(top: value);
  EdgeInsets get bPadding => EdgeInsets.only(bottom: value);
  EdgeInsets get lPadding => EdgeInsets.only(left: value);
  EdgeInsets get rPadding => EdgeInsets.only(right: value);

  SizedBox get hGap => SizedBox(width: value);
  SizedBox get vGap => SizedBox(height: value);
}
