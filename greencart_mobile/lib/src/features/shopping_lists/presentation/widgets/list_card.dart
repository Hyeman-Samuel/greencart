import 'package:flutter/material.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLastCard;

  const ListCard({
    super.key,
    required this.title,
    this.onTap,
    this.isLastCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: Sizes.p16.hPadding + Sizes.p14.vPadding,
            decoration: BoxDecoration(
              color: AppColors.cardBackground.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Skeleton.leaf(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      IconsaxPlusBold.note_text,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ),
                Sizes.p12.hGap,
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        if (!isLastCard) Sizes.p12.vGap,
      ],
    );
  }
}
