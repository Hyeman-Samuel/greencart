import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/data/datasources/list_products_data_source.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_alternatives_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_categories_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_category_products_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_list_products_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'list_products_repository.g.dart';

class ListProuctsRepository {
  ListProuctsRepository({required this.apiDataSource, required this.logger});
  final ListProductsDataSource apiDataSource;
  final Talker logger;

  FutureResultOf<FetchListProductsResponse> getListProducts({
    required String id,
    required CancelToken cancelToken,
  }) async {
    final response = await Result.fromAsync(
      () => apiDataSource.getListProducts(id: id, cancelToken: cancelToken),
    );
    return response;
  }

  FutureResultOf<FetchCategoriesResponse> getCategories() async {
    final response = await Result.fromAsync(
      () => apiDataSource.getCategories(),
    );
    return response;
  }

  FutureResultOf<FetchCategoryProductsResponse> getCategoryProducts({
    required String category,
  }) async {
    final response = await Result.fromAsync(
      () => apiDataSource.getCategoryProducts(category: category),
    );
    return response;
  }

  FutureResultOf<FetchAlternativesResponse> getProductAlternatives({
    required String productId,
  }) async {
    final response = await Result.fromAsync(
      () => apiDataSource.getProductAlternatives(id: productId),
    );
    return response;
  }

  FutureResultOf<dynamic> addProduct({
    required String listId,
    required String productId,
  }) async {
    final response = await Result.fromAsync(
      () =>
          apiDataSource.addProduct(id: listId, payload: {"product": productId}),
    );
    return response;
  }
}

@riverpod
ListProuctsRepository listProductsRepository(Ref ref) {
  final logger = ref.watch(talkerLoggerProvider);
  final listProductsDataSource = ref.watch(listProductsDataSourceProvider);

  return ListProuctsRepository(
    apiDataSource: listProductsDataSource,
    logger: logger,
  );
}
