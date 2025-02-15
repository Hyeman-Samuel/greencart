import 'package:dio/dio.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/shopping_lists/data/repositories/shopping_lists_repository.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/add_list_payload.dart';
import 'package:greencart_app/src/features/shopping_lists/presentation/controllers/shopping_lists_controller.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_list_controller.g.dart';

@riverpod
class AddListController extends _$AddListController {
  final CancelToken _cancelToken = CancelToken();
  late final ShoppingListsRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.watch(shoppingListsRepositoryProvider);
    ref.onDispose(() => _cancelToken.cancel());
  }

  void addList({required String title}) async {
    final list = AddListPayload(title: title);
    state = AsyncLoading();

    final result = await _repository.addList(
      payload: list,
      cancelToken: _cancelToken,
    );
    state = result.fold(
      (data) {
        ref.read(appRouterProvider).popForced(true);
        ref.invalidate(fetchAllListsProvider);
        AppToasts.success(message: "${data.list?.title} created!");
        return AsyncData(data);
      },
      (error) {
        AppToasts.error(message: error.toString());
        ref.read(errorLoggerProvider).logException(error, StackTrace.current);
        return AsyncError(error, StackTrace.current);
      },
    );
  }
}
