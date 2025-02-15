import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_list_payload.freezed.dart';
part 'add_list_payload.g.dart';

@freezed
class AddListPayload with _$AddListPayload {
  factory AddListPayload({
    required String title,
    @Default("Description") String? description,
  }) = _AddListPayload;

  factory AddListPayload.fromJson(Map<String, dynamic> json) =>
      _$AddListPayloadFromJson(json);
}
