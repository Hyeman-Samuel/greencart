import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/profile/domain/models/user_profile_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_data_source.g.dart';

@RestApi()
abstract class ProfileDataSource {
  factory ProfileDataSource(Dio dio, {String baseUrl}) = _ProfileDataSource;

  @GET('v1/users/profile')
  Future<UserProfileResponse> getUserProfile({
    @CancelRequest() required CancelToken cancelToken,
  });
}

@riverpod
ProfileDataSource profileDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ProfileDataSource(dio);
}
