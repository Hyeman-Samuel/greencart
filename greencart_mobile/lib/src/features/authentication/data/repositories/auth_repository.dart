import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/authentication/data/datasources/auth_data_source.dart';
import 'package:greencart_app/src/features/authentication/domain/models/auth_payload.dart';
import 'package:greencart_app/src/features/authentication/domain/models/auth_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({
    required this.apiDataSource,
    required this.localCache,
    required this.logger,
  });
  final AuthDataSource apiDataSource;
  final LocalCache localCache;
  final Talker logger;

  FutureResultOf<AuthResponse> signUp({required AuthPayload payload}) async {
    final signUpResult = await Result.fromAsync(
      () => apiDataSource.signUp(payload: payload),
    );

    final result = await signUpResult.asyncFlatMap((s) async {
      await Sentry.configureScope((scope) {
        scope.setUser(
          SentryUser(
            id: s.user?.id,
            name: s.user?.fullName,
            email: s.user?.email,
          ),
        );
      });
      await localCache.saveToken(s.token!);
      return signUpResult;
    });

    return result;
  }

  FutureResultOf<AuthResponse> signIn({required AuthPayload payload}) async {
    final signInResult = await Result.fromAsync(
      () => apiDataSource.signIn(payload: payload),
    );

    final result = await signInResult.asyncFlatMap((s) async {
      await Sentry.configureScope((scope) {
        scope.setUser(
          SentryUser(
            id: s.user?.id,
            name: s.user?.fullName,
            email: s.user?.email,
          ),
        );
      });
      await localCache.saveToken(s.token!);
      return signInResult;
    });

    return result;
  }

  Future<dynamic> logout() async {
    await localCache.deleteToken();
    await Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final logger = ref.watch(talkerLoggerProvider);
  final authDataSource = ref.watch(authDataSourceProvider);
  final localCache = ref.watch(localCacheProvider);

  return AuthRepository(
    apiDataSource: authDataSource,
    localCache: localCache,
    logger: logger,
  );
}
