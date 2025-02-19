import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/shopping_lists/data/repositories/shopping_lists_repository.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_lists_controller.g.dart';

@riverpod
Future<FetchListsResponse> fetchAllLists(Ref ref) async {
  final result = await ref.watch(shoppingListsRepositoryProvider).getAllLists();
  return result.fold((response) => response, (error) {
    ref.read(errorLoggerProvider).logException(error, StackTrace.current);
    throw error;
  });
}

@riverpod
class ShoppingListsController extends _$ShoppingListsController {
  late final ShoppingListsRepository _shoppingListsRepository;
  final CancelToken _cancelToken = CancelToken();

  @override
  FutureOr<void> build() {
    _shoppingListsRepository = ref.watch(shoppingListsRepositoryProvider);
    ref.onDispose(() => _cancelToken.cancel());
  }

  Future<void> deleteList(
      {required String id, bool swipeToDelete = false}) async {
    state = AsyncLoading();
    final result = await _shoppingListsRepository.deleteList(id: id);
    state = result.fold(
      (data) {
        if (!swipeToDelete) {
          ref.read(appRouterProvider).popForced();
        }
        ref.invalidate(fetchAllListsProvider);
        AppToasts.success(message: "List deleted successfully!");
        return AsyncData(data);
      },
      (error) {
        AppToasts.error(longMessage: "Error deleting list. Please try again.");
        ref.read(errorLoggerProvider).logException(error, StackTrace.current);
        return AsyncError(error, StackTrace.current);
      },
    );
  }
}
