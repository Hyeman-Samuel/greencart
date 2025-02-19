import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greencart_app/src/config/navigation/app_router.gr.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/shopping_lists/presentation/controllers/shopping_lists_controller.dart';
import 'package:greencart_app/src/features/shopping_lists/presentation/widgets/list_card.dart';
import 'package:greencart_app/src/shared/shared.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool shouldSkipLoadingOnRefresh = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      showAppBar: false,
      body: AdaptiveRefreshIdicator(
        onRefresh: () {
          shouldSkipLoadingOnRefresh = true;
          return ref.refresh(fetchAllListsProvider.future);
        },
        slivers: <Widget>[
          SliverAppBar.medium(
            pinned: true,
            titleSpacing: 0.0,
            expandedHeight: 100,
            title: Text(
              'Lists',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton.filledTonal(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.black,
                ),
                icon: Icon(Icons.person_2_rounded),
                onPressed: () => context.router.push(ProfileScreenRoute()),
              ),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(fetchAllListsProvider);
              return state.when(
                skipLoadingOnRefresh: shouldSkipLoadingOnRefresh,
                data: (data) {
                  final lists = data.list ?? [];
                  if (lists.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GreenCartAssets.images.clipboardIllustration.image(),
                          Sizes.p16.vGap,
                          Text(
                            'Start by creating a list',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Your shopping lists will be shown here',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SliverPadding(
                      padding: Sizes.p16.vPadding,
                      sliver: SliverList.builder(
                        itemCount: data.list?.length,
                        itemBuilder: (context, index) {
                          final isLast = index == data.list!.length - 1;
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                Sizes.p8.hGap,
                                SlidableAction(
                                  borderRadius: BorderRadius.circular(8),
                                  flex: 2,
                                  onPressed: (context) =>
                                      AppDialogs.showAlertDialog(
                                    context: context,
                                    title: 'Coming soon!',
                                    content:
                                        'Thanks for expressing your interest in this feature.',
                                  ),
                                  backgroundColor: AppColors.info,
                                  foregroundColor: Colors.white,
                                  icon: Icons.print_rounded,
                                ),
                                Sizes.p8.hGap,
                                Consumer(
                                  builder: (context, ref, child) {
                                    return SlidableAction(
                                      borderRadius: BorderRadius.circular(8),
                                      flex: 2,
                                      onPressed: (context) => ref
                                          .read(shoppingListsControllerProvider
                                              .notifier)
                                          .deleteList(
                                            id: lists[index].id ?? '',
                                            swipeToDelete: true,
                                          ),
                                      backgroundColor: AppColors.brightRed,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_rounded,
                                    );
                                  },
                                ),
                              ],
                            ),
                            child: ListCard(
                              onTap: () => context.router.push(
                                ListProductsScreenRoute(
                                  id: lists[index].id ?? '',
                                  listName: lists[index].title ?? '',
                                ),
                              ),
                              title: lists[index].title ?? '',
                              isLastCard: isLast,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
                loading: () => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Shimmer(
                    child: Column(
                      children: List.generate(
                        10,
                        (index) => ListCard(title: 'Shimmer Title...'),
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
                      ref.invalidate(fetchAllListsProvider);
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
        onPressed: () => context.router.push(AddListScreenRoute()),
        child: Icon(Icons.add),
      ),
    );
  }
}
