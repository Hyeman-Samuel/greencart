import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/domain/models/product.dart';
import 'package:greencart_app/src/features/list_products/presentation/controllers/list_products_controller.dart';
import 'package:greencart_app/src/features/list_products/presentation/widgets/product_card.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ProductsScreen extends ConsumerStatefulWidget {
  final String listId;

  const ProductsScreen({super.key, required this.listId});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool shouldSkipLoadingOnRefresh = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      scrollable: false,
      showAppBar: true,
      title: 'Products',
      body: Consumer(
        builder: (context, ref, child) {
          final categoriesState = ref.watch(fetchCategoriesProvider);
          return Column(
            children: [
              categoriesState.when(
                skipLoadingOnRefresh: shouldSkipLoadingOnRefresh,
                data: (data) {
                  final tabs = data.categories ?? [];
                  _tabController = TabController(
                    length: tabs.length,
                    vsync: this,
                  );
                  return TabBar(
                    controller: _tabController,
                    tabAlignment: TabAlignment.center,
                    indicatorAnimation: TabIndicatorAnimation.linear,
                    isScrollable: true,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray700,
                    ),
                    tabs: List.generate(
                      tabs.length,
                      (int index) => Tab(text: tabs[index]),
                    ),
                  );
                },
                loading: () => Shimmer.zone(
                  child: Bone(height: 50, width: double.infinity),
                ),
                error: (error, _) => ErrorDisplay(
                  errorDescription:
                      'Error loading categories. Please try again.',
                  onRetry: () {
                    shouldSkipLoadingOnRefresh = false;
                    return ref.refresh(fetchCategoriesProvider);
                  },
                ),
              ),
              categoriesState.maybeWhen(
                data: (data) {
                  final tabs = data.categories!;
                  return Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                        tabs.length,
                        (int index) => Consumer(
                          builder: (context, ref, child) {
                            final category = tabs[index];
                            final categoryProductsState = ref.watch(
                              fetchCategoryProductsProvider(category: category),
                            );
                            return categoryProductsState.when(
                              skipLoadingOnRefresh: shouldSkipLoadingOnRefresh,
                              data: (data) {
                                final products = data.product ?? [];

                                return AdaptiveRefreshIdicator(
                                  onRefresh: () async {
                                    shouldSkipLoadingOnRefresh = true;
                                    return ref.refresh(
                                      fetchCategoryProductsProvider(
                                        category: category,
                                      ),
                                    );
                                  },
                                  slivers: [
                                    if (products.isEmpty) ...[
                                      SliverFillRemaining(
                                        hasScrollBody: false,
                                        child: Center(
                                          child: Text(
                                            'No products available',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.mediumGray,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ] else
                                      _TabBody(
                                        products: products,
                                        listId: widget.listId,
                                      ),
                                  ],
                                );
                              },
                              loading: () => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator.adaptive(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primary,
                                    ),
                                  ),
                                  Sizes.p16.vGap,
                                  Text(
                                    'Loading products...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mediumGray,
                                    ),
                                  ),
                                ],
                              ),
                              error: (error, _) => ErrorDisplay(
                                errorDescription:
                                    'Error loading products. Please try again.',
                                onRetry: () {
                                  shouldSkipLoadingOnRefresh = false;
                                  return ref.refresh(
                                    fetchCategoryProductsProvider(
                                      category: category,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TabBody extends StatefulWidget {
  const _TabBody({required this.products, required this.listId});

  final List<Product> products;
  final String listId;

  @override
  State<_TabBody> createState() => _TabBodyState();
}

class _TabBodyState extends State<_TabBody> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SliverPadding(
      padding: Sizes.p24.hPadding + Sizes.p20.vPadding,
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return ProductCard(product: product, listId: widget.listId);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
