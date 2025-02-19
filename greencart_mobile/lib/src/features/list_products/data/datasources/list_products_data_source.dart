import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_alternatives_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_categories_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_category_products_response.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_list_products_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'list_products_data_source.g.dart';

@RestApi()
abstract class ListProductsDataSource {
  factory ListProductsDataSource(Dio dio, {String baseUrl}) =
      _ListProductsDataSource;

  @GET('v1/lists/{id}')
  Future<FetchListProductsResponse> getListProducts({
    @Path('id') required String id,
    @CancelRequest() required CancelToken cancelToken,
  });

  @GET('v1/categories/')
  Future<FetchCategoriesResponse> getCategories();

  @GET('v1/products/')
  Future<FetchCategoryProductsResponse> getCategoryProducts({
    @Query('category') required String category,
    @Query('offset') int? offset,
    @Query('limit') int? limit,
  });

  @GET('v1/products/{id}/alternatives')
  Future<FetchAlternativesResponse> getProductAlternatives({
    @Path('id') required String id,
    @Query('offset') int? offset,
    @Query('limit') int? limit,
  });

  @POST('v1/lists/{id}')
  Future<dynamic> addProduct({
    @Path('id') required String id,
    @Body() required Map<String, String> payload,
  });

  @DELETE('v1/lists/{id}')
  Future<dynamic> deleteProduct({
    @Path('id') required String id,
    @Body() required Map<String, String> payload,
  });
}

@riverpod
ListProductsDataSource listProductsDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ListProductsDataSource(dio);
}
