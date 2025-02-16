import 'package:flutter/material.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListProductCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLastCard;

  const ListProductCard({
    super.key,
    required this.title,
    this.onTap,
    this.isLastCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Skeleton.leaf(
            child: Container(
              width: double.infinity,
              padding: Sizes.p16.allPadding,
              decoration: BoxDecoration(
                color: AppColors.gray25,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.gray200),
              ),
              child: Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        if (!isLastCard) Sizes.p12.vGap,
      ],
    );
  }
}
