import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/authentication/domain/models/auth_payload.dart';
import 'package:greencart_app/src/features/authentication/domain/models/auth_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_data_source.g.dart';

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String baseUrl}) = _AuthDataSource;

  @POST('v1/users/')
  Future<AuthResponse> signUp({@Body() required AuthPayload payload});

  @POST('v1/users/login')
  Future<AuthResponse> signIn({@Body() required AuthPayload payload});
}

@riverpod
AuthDataSource authDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthDataSource(dio);
}
