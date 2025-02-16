import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greencart_app/src/features/authentication/domain/models/user_details.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    UserDetails? user,
    String? token,
    String? name,
    String? message,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
