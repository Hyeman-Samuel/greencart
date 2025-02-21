import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/config/navigation/app_router.gr.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:greencart_app/src/features/authentication/data/repositories/auth_repository.dart';
import 'package:greencart_app/src/features/authentication/domain/models/auth_payload.dart';
import 'package:greencart_app/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  Object? _key;
  late final AuthRepository _authRepository;

  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => _key = null);
    _authRepository = ref.watch(authRepositoryProvider);
  }

  Future<void> signUp(AuthPayload payload) async {
    state = AsyncLoading();
    final key = _key;
    final result = await _authRepository.signUp(payload: payload);
    if (key == _key) {
      state = result.fold(
        (data) {
          ref.read(appRouterProvider).popForced(true);
          _navigateToHomeScreen();
          AppToasts.success(message: "Account created successfully!");
          return AsyncData(data);
        },
        (error) {
          ref.read(appRouterProvider).popForced(true);
          ref.read(errorLoggerProvider).logException(error, StackTrace.current);
          return AsyncError(error, StackTrace.current);
        },
      );
    }
  }

  Future<void> signIn(AuthPayload payload) async {
    state = AsyncLoading();
    final key = _key;
    final result = await _authRepository.signIn(payload: payload);
    if (key == _key) {
      state = result.fold(
        (data) {
          ref.read(appRouterProvider).popForced(true);
          _navigateToHomeScreen();
          AppToasts.success(message: "Sign in successful!");
          return AsyncData(data);
        },
        (error) {
          ref.read(appRouterProvider).popForced(true);
          ref.read(errorLoggerProvider).logException(error, StackTrace.current);
          return AsyncError(error, StackTrace.current);
        },
      );
    }
  }

  Future<void> logout() async {
    state = AsyncLoading();
    await _authRepository.logout();
    _navigateToOnboardingScreen();
    AppToasts.success(message: "Logout successful!");
  }

  void _navigateToOnboardingScreen() {
    ref.read(appRouterProvider).popForced(true);
    ref.read(appRouterProvider).popForced(true);
    ref.read(appRouterProvider).push(OnboardingScreenRoute());
  }

  void _navigateToHomeScreen() {
    ref.read(appRouterProvider).popForced(true);
    ref.read(appRouterProvider).popForced(true);
    ref.read(appRouterProvider).push(HomeScreenRoute());
  }

  void goToSignInScreen() {
    ref.read(appRouterProvider).popForced(true);
    ref.read(appRouterProvider).push(SignInScreenRoute());
  }

  void goToSignUpScreen() {
    ref.read(appRouterProvider).popForced(true);
    ref.read(appRouterProvider).push(SignUpScreenRoute());
  }
}
