import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? type,
    String? category,
    @JsonKey(name: 'carbon_emission') int? carbonEmission,
    String? thumbnail,
    int? price,
    String? metric,
    String? rating,
    int? quantity,
    @JsonKey(name: '__v') int? v,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  static final dummyData = Product();
}
