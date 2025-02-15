import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/list_products/domain/models/product.dart';

part 'alternative.freezed.dart';
part 'alternative.g.dart';

@freezed
class Alternative with _$Alternative {
  factory Alternative({
    Product? x,
    @JsonKey(name: 'carbon_reduction') String? carbonReduction,
  }) = _Alternative;

  factory Alternative.fromJson(Map<String, dynamic> json) =>
      _$AlternativeFromJson(json);
}
