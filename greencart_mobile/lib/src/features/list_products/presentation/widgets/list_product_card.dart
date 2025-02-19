import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/presentation/controllers/list_products_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListProductCard extends StatelessWidget {
  final String title;
  final String listId;
  final String productId;
  final VoidCallback? onTap;
  final bool isLastCard;

  const ListProductCard({
    super.key,
    required this.title,
    required this.listId,
    required this.productId,
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
            child: Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  Sizes.p8.hGap,
                  Consumer(
                    builder: (context, ref, child) {
                      return SlidableAction(
                        borderRadius: BorderRadius.circular(8),
                        onPressed: (context) => ref
                            .read(listProductsControllerProvider(productId)
                                .notifier)
                            .deleteProduct(listId: listId),
                        backgroundColor: AppColors.brightRed,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_rounded,
                      );
                    },
                  ),
                ],
              ),
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
        ),
        if (!isLastCard) Sizes.p12.vGap,
      ],
    );
  }
}
