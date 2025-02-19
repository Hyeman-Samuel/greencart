import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/navigation/app_router.gr.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/presentation/controllers/list_products_controller.dart';
import 'package:greencart_app/src/features/list_products/presentation/widgets/list_product_card.dart';
import 'package:greencart_app/src/features/shopping_lists/presentation/controllers/shopping_lists_controller.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ListProductsScreen extends ConsumerStatefulWidget {
  final String id;
  final String listName;
  const ListProductsScreen({
    super.key,
    @PathParam() required this.id,
    required this.listName,
  });

  @override
  ConsumerState<ListProductsScreen> createState() => _ListProductsScreenState();
}

class _ListProductsScreenState extends ConsumerState<ListProductsScreen> {
  bool shouldSkipLoadingOnRefresh = true;
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(shoppingListsControllerProvider);
    return AppScaffold(
      scrollable: false,
      showAppBar: true,
      appBarActions: [
        if (state.isLoading) ...[
          Row(
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator.adaptive(),
              ),
              Sizes.p16.hGap,
            ],
          ),
        ] else
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => ref
                .read(shoppingListsControllerProvider.notifier)
                .deleteList(id: widget.id),
          ),
      ],
      body: AdaptiveRefreshIdicator(
        onRefresh: () {
          shouldSkipLoadingOnRefresh = true;
          return ref.refresh(fetchListProductsProvider(id: widget.id).future);
        },
        slivers: <Widget>[
          SliverToBoxAdapter(child: _Header(title: widget.listName)),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(fetchListProductsProvider(id: widget.id));
              return state.when(
                skipLoadingOnRefresh: shouldSkipLoadingOnRefresh,
                data: (data) {
                  final lists = data.list ?? [];
                  if (lists.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No items added',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mediumGray,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SliverList.builder(
                      itemCount: data.list?.length,
                      itemBuilder: (context, index) {
                        final isLast = index == data.list!.length - 1;
                        return ListProductCard(
                          title: lists[index].product?.title ?? '',
                          listId: widget.id,
                          productId: lists[index].product?.id ?? '',
                          isLastCard: isLast,
                          onTap: () {},
                        );
                      },
                    );
                  }
                },
                loading: () => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Shimmer(
                    child: Column(
                      children: List.generate(
                        10,
                        (index) => Skeletonizer(
                          ignoreContainers: true,
                          child: ListProductCard(
                            listId: '',
                            productId: '',
                            title: 'Shimmer Title...',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                error: (error, stackTrace) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorDisplay(
                    errorDescription: error.toString(),
                    onRetry: () {
                      shouldSkipLoadingOnRefresh = false;
                      ref.invalidate(
                        fetchListProductsProvider(id: widget.id),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
        onPressed: () =>
            context.router.push(ProductsScreenRoute(listId: widget.id)),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Sizes.p12.vPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () => AppDialogs.showAlertDialog(
                  context: context,
                  title: 'Coming soon!',
                  content:
                      'Thanks for expressing your interest in this feature.',
                ),
                child: Text(
                  'Print list',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          Sizes.p12.vGap,
        ],
      ),
    );
  }
}
