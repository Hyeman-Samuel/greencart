import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/profile/data/repositories/profile_repository.dart';
import 'package:greencart_app/src/features/profile/domain/models/user_profile_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_screen_controller.g.dart';

@Riverpod(keepAlive: true)
Future<UserProfileResponse> fetchUserProfile(Ref ref) async {
  final cancelToken = CancelToken();
  ref.onDispose(() => cancelToken.cancel());
  final result = await ref
      .watch(profileRepositoryProvider)
      .getUserProfile(cancelToken: cancelToken);
  return result.fold(
    (response) => response,
    (error) {
      ref.read(errorLoggerProvider).logException(error, StackTrace.current);
      throw error;
    },
  );
}
