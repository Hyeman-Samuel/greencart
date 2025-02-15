import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/shopping_lists/domain/models/shopping_list.dart';

part 'add_list_response.freezed.dart';
part 'add_list_response.g.dart';

@freezed
class AddListResponse with _$AddListResponse {
  factory AddListResponse({ShoppingList? list, String? name, String? message}) =
      _AddListResponse;

  factory AddListResponse.fromJson(Map<String, dynamic> json) =>
      _$AddListResponseFromJson(json);
}
