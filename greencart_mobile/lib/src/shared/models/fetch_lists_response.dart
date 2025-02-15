import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/shopping_list.dart';

part 'fetch_lists_response.freezed.dart';
part 'fetch_lists_response.g.dart';

@freezed
class FetchListsResponse with _$FetchListsResponse {
  factory FetchListsResponse({
    List<ShoppingList>? list,
    String? name,
    String? message,
  }) = _FetchListsResponse;

  factory FetchListsResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchListsResponseFromJson(json);
}
