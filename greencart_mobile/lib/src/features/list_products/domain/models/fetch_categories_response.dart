import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_categories_response.freezed.dart';
part 'fetch_categories_response.g.dart';

@freezed
class FetchCategoriesResponse with _$FetchCategoriesResponse {
  factory FetchCategoriesResponse({List<String>? categories}) =
      _FetchCategoriesResponse;

  factory FetchCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchCategoriesResponseFromJson(json);
}
