import 'package:flutter/material.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.errorDescription,
    this.onRetry,
    this.padding = 20,
    this.assetSize = 48,
    this.actionText = 'Retry',
  });

  final String errorDescription;
  final String actionText;
  final VoidCallback? onRetry;
  final double padding;
  final double assetSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            errorDescription,
            textAlign: TextAlign.center,
            style: context.appTextTheme.smallTextRegular.copyWith(
              color: AppColors.gray3,
            ),
          ),
          Sizes.p16.vGap,
          ElevatedButton.icon(
            onPressed: onRetry,
            label: Text(
              actionText,
              style: context.appTextTheme.smallTextRegular,
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: padding / 2,
              ),
              backgroundColor: AppColors.primary.withValues(alpha: 0.8),
              foregroundColor: AppColors.white,
            ),
            icon: Icon(IconsaxPlusLinear.refresh_2, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
