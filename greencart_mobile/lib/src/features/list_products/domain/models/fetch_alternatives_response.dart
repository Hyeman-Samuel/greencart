import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/list_products/domain/models/alternative.dart';

part 'fetch_alternatives_response.freezed.dart';
part 'fetch_alternatives_response.g.dart';

@freezed
class FetchAlternativesResponse with _$FetchAlternativesResponse {
  factory FetchAlternativesResponse({List<Alternative>? products}) =
      _FetchAlternativesResponse;

  factory FetchAlternativesResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchAlternativesResponseFromJson(json);
}
