import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/domain/models/product.dart';
import 'package:greencart_app/src/features/list_products/presentation/controllers/list_products_controller.dart';
import 'package:greencart_app/src/features/list_products/presentation/widgets/alternatives_bottom_sheet.dart';
import 'package:universal_image/universal_image.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.listId,
  });

  final String listId;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: Sizes.p16.allPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gridContainerBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: UniversalImage(
              product.thumbnail,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Sizes.p12.vGap,
          Flexible(
            child: Text(
              product.title!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            '₦${product.price?.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.gray700,
            ),
          ),
          Sizes.p8.vGap,
          Flexible(
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  builder: (context) => AlternativesBottomSheet(
                    productId: product.id!,
                    listId: listId,
                  ),
                );
              },
              child: Text(
                'Check alternatives',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          Sizes.p8.vGap,
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                ref
                    .read(addProductControllerProvider(product.id).notifier)
                    .addProduct(listId: listId);
              },
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(
                    addProductControllerProvider(product.id),
                  );
                  return state.maybeWhen(
                    loading: () => SizedBox(
                      width: 34,
                      height: 34,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
                    orElse: () => Container(
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
