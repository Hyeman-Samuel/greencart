import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/presentation/controllers/list_products_controller.dart';
import 'package:greencart_app/src/features/list_products/presentation/widgets/alternatives_item_card.dart';
import 'package:greencart_app/src/shared/shared.dart';

class AlternativesBottomSheet extends ConsumerWidget {
  final String productId;
  final String listId;
  const AlternativesBottomSheet({
    super.key,
    required this.productId,
    required this.listId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      fetchProductAlternativesProvider(productId: productId),
    );
    return Container(
      padding: Sizes.p16.hPadding,
      height: context.mediaQuerySize.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.close_rounded,
                  size: 28,
                ),
                onPressed: () => context.router.popForced(),
              ),
            ],
          ),
          state.when(
            data: (data) {
              final products = data.products ?? [];
              if (products.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'No alternatives available yet. Please check again later.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mediumGray,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return AlternativesItemCard(
                        image: product.x?.thumbnail ?? '',
                        title: product.x?.title ?? '',
                        price: '₦${product.x?.price?.toStringAsFixed(2)}',
                        emission: product.carbonReduction ?? '',
                        listId: listId,
                        productId: product.x?.id ?? '',
                      );
                    },
                  ),
                );
              }
            },
            loading: () {
              return Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Shimmer(
                      child: AlternativesItemCard(
                        image: '',
                        title: 'This is dummy text',
                        price: '₦0.00',
                        emission: '20%',
                        listId: '',
                        productId: '',
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, _) => ErrorDisplay(
              errorDescription: 'Error loading alternatives. Please try again.',
              onRetry: () => ref.refresh(
                fetchProductAlternativesProvider(productId: productId),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
