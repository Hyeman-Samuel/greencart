import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/presentation/controllers/list_products_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:universal_image/universal_image.dart';

class AlternativesItemCard extends ConsumerWidget {
  final String image;
  final String title;
  final String price;
  final String emission;
  final String listId;
  final String productId;

  const AlternativesItemCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.emission,
    required this.listId,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: Sizes.p16.bPadding,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.gray200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Skeleton.replace(
              width: 125,
              height: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: UniversalImage(
                  image,
                  width: 125,
                  height: 125,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Sizes.p4.hGap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(price, style: const TextStyle(color: Colors.grey)),
                Text(
                  "You've reduced CO₂ emission by $emission% by choosing $title",
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Sizes.p2.hGap,
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(addProductControllerProvider(productId).notifier)
                    .addProduct(listId: listId);
              },
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(
                    addProductControllerProvider(productId),
                  );
                  return state.maybeWhen(
                    loading: () => SizedBox(
                      width: 34,
                      height: 34,
                      child: const CircularProgressIndicator.adaptive(
                      ),
                    ),
                    orElse: () => Skeleton.leaf(
                      child: Container(
                        padding: Sizes.p8.allPadding,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: AppColors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
