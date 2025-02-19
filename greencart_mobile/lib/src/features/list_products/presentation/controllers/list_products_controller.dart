import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/data/repositories/list_products_repository.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_alternatives_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_categories_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_category_products_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_list_products_response.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_products_controller.g.dart';

@riverpod
Future<FetchListProductsResponse> fetchListProducts(
  Ref ref, {
  required String id,
}) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  final result = await ref
      .watch(listProductsRepositoryProvider)
      .getListProducts(id: id, cancelToken: cancelToken);
  return result.fold((response) => response, (error) {
    ref.read(errorLoggerProvider).logException(error, StackTrace.current);
    throw error;
  });
}

@Riverpod(keepAlive: true)
Future<FetchCategoriesResponse> fetchCategories(Ref ref) async {
  final result =
      await ref.watch(listProductsRepositoryProvider).getCategories();
  return result.fold((response) => response, (error) {
    ref.read(errorLoggerProvider).logException(error, StackTrace.current);
    throw error;
  });
}

@riverpod
Future<FetchCategoryProductsResponse> fetchCategoryProducts(
  Ref ref, {
  required String category,
}) async {
  final result = await ref
      .watch(listProductsRepositoryProvider)
      .getCategoryProducts(category: category);
  return result.fold((response) => response, (error) {
    ref.read(errorLoggerProvider).logException(error, StackTrace.current);
    throw error;
  });
}

@riverpod
Future<FetchAlternativesResponse> fetchProductAlternatives(
  Ref ref, {
  required String productId,
}) async {
  final result = await ref
      .watch(listProductsRepositoryProvider)
      .getProductAlternatives(productId: productId);
  return result.fold((response) => response, (error) {
    ref.read(errorLoggerProvider).logException(error, StackTrace.current);
    throw error;
  });
}

@riverpod
class ListProductsController extends _$ListProductsController {
  late final ListProuctsRepository _repository;

  @override
  FutureOr<void> build(String? productId) {
    _repository = ref.watch(listProductsRepositoryProvider);
  }

  void addProduct({required String listId}) async {
    state = AsyncLoading();

    final result = await _repository.addProduct(
      listId: listId,
      productId: productId ?? '',
    );

    state = result.fold(
      (data) {
        ref.invalidate(fetchListProductsProvider);
        AppToasts.success(message: "Product added!");
        return AsyncData(data);
      },
      (error) {
        AppToasts.error(longMessage: 'Error adding product. Please try again.');
        ref.read(errorLoggerProvider).logException(error, StackTrace.current);
        return AsyncError(error, StackTrace.current);
      },
    );
  }

  void deleteProduct({required String listId}) async {
    state = AsyncLoading();

    final result = await _repository.deleteProduct(
      listId: listId,
      productId: productId ?? '',
    );

    state = result.fold(
      (data) {
        ref.invalidate(fetchListProductsProvider);
        AppToasts.success(message: "Product deleted!");
        return AsyncData(data);
      },
      (error) {
        AppToasts.error(
            longMessage: 'Error deleting product. Please try again.');
        ref.read(errorLoggerProvider).logException(error, StackTrace.current);
        return AsyncError(error, StackTrace.current);
      },
    );
  }
}
