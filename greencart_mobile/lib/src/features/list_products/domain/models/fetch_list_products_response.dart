import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:greencart_app/src/features/list_products/domain/models/list_product.dart';

part 'fetch_list_products_response.freezed.dart';
part 'fetch_list_products_response.g.dart';

@freezed
class FetchListProductsResponse with _$FetchListProductsResponse {
  factory FetchListProductsResponse({List<ListProduct>? list}) =
      _FetchListProductsResponse;

  factory FetchListProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchListProductsResponseFromJson(json);
}
