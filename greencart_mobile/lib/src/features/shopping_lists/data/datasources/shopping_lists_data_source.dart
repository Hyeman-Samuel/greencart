import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/list_products/domain/models/fetch_list_products_response.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/add_list_payload.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/add_list_response.dart';
import 'package:greencart_app/src/shared/models/fetch_lists_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_lists_data_source.g.dart';

@RestApi()
abstract class ShoppingListsDataSource {
  factory ShoppingListsDataSource(Dio dio, {String baseUrl}) =
      _ShoppingListsDataSource;

  @GET('v1/lists/')
  Future<FetchListsResponse> getAllLists();

  @POST('v1/lists/')
  Future<AddListResponse> addList({
    @Body() required AddListPayload payload,
    @CancelRequest() required CancelToken cancelToken,
  });

  @DELETE('/v1/lists/{id}/delete')
  Future<FetchListProductsResponse> deleteList({
    @Path('id') required String id,
  });
}

@riverpod
ShoppingListsDataSource shoppingListsDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ShoppingListsDataSource(dio);
}
