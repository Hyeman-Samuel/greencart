import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_list_products_response.dart';
import 'package:greencart_app/src/features/shopping_lists/data/datasources/shopping_lists_data_source.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/add_list_payload.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/add_list_response.dart';
import 'package:greencart_app/src/shared/models/fetch_lists_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'shopping_lists_repository.g.dart';

class ShoppingListsRepository {
  ShoppingListsRepository({required this.apiDataSource, required this.logger});
  final ShoppingListsDataSource apiDataSource;
  final Talker logger;

  FutureResultOf<FetchListsResponse> getAllLists() async {
    final response = await Result.fromAsync(() => apiDataSource.getAllLists());
    return response;
  }

  FutureResultOf<AddListResponse> addList({
    required AddListPayload payload,
    required CancelToken cancelToken,
  }) async {
    final response = await Result.fromAsync(
      () => apiDataSource.addList(payload: payload, cancelToken: cancelToken),
    );
    return response;
  }

  FutureResultOf<FetchListProductsResponse> deleteList({
    required String id,
    required CancelToken cancelToken,
  }) async {
    final response = await Result.fromAsync(
      () => apiDataSource.deleteList(id: id, cancelToken: cancelToken),
    );
    return response;
  }
}

@riverpod
ShoppingListsRepository shoppingListsRepository(Ref ref) {
  final logger = ref.watch(talkerLoggerProvider);
  final shoppingListsDataSource = ref.watch(shoppingListsDataSourceProvider);

  return ShoppingListsRepository(
    apiDataSource: shoppingListsDataSource,
    logger: logger,
  );
}
