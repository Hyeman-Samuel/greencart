import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/list_products/domain/models/product.dart';

part 'list_product.freezed.dart';
part 'list_product.g.dart';

@freezed
class ListProduct with _$ListProduct {
  factory ListProduct({
    @JsonKey(name: '_id') String? id,
    int? quantity,
    Product? product,
    @JsonKey(name: '__v') int? v,
  }) = _ListProduct;

  factory ListProduct.fromJson(Map<String, dynamic> json) =>
      _$ListProductFromJson(json);
}
