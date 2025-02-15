import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/list_products/domain/models/product.dart';

part 'fetch_category_products_response.freezed.dart';
part 'fetch_category_products_response.g.dart';

@freezed
class FetchCategoryProductsResponse with _$FetchCategoryProductsResponse {
  factory FetchCategoryProductsResponse({List<Product>? product}) =
      _FetchCategoryProductsResponse;

  factory FetchCategoryProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchCategoryProductsResponseFromJson(json);
}
