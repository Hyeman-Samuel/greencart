import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/profile/data/datasources/profile_data_source.dart';
import 'package:greencart_app/src/features/profile/domain/models/user_profile_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'profile_repository.g.dart';

class ProfileRepository {
  ProfileRepository({required this.apiDataSource, required this.logger});
  final ProfileDataSource apiDataSource;
  final Talker logger;

  FutureResultOf<UserProfileResponse> getUserProfile({
    required CancelToken cancelToken,
  }) async {
    final response = await Result.fromAsync(
      () => apiDataSource.getUserProfile(cancelToken: cancelToken),
    );
    return response;
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final logger = ref.watch(talkerLoggerProvider);
  final profileDataSource = ref.watch(profileDataSourceProvider);

  return ProfileRepository(
    apiDataSource: profileDataSource,
    logger: logger,
  );
}
