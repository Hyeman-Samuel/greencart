import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/config/navigation/app_router.gr.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@AutoRouterConfig(replaceInRouteName: '')
class AppRouter extends RootStackRouter {
  final Ref ref;

  AppRouter({required this.ref});

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  late final List<AutoRoute> routes = [
    AutoRoute(
      initial: true,
      path: '/onboarding',
      page: OnboardingScreenRoute.page,
      guards: [AuthGuard(ref: ref)],
    ),
    AutoRoute(path: '/sign-up', page: SignUpScreenRoute.page),
    AutoRoute(path: '/sign-in', page: SignInScreenRoute.page),
    AutoRoute(path: '/home-screen', page: HomeScreenRoute.page),
    AutoRoute(path: '/profile-screen', page: ProfileScreenRoute.page),
    AutoRoute(
      path: '/add-list',
      page: AddListScreenRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(path: '/list-products/:id', page: ListProductsScreenRoute.page),
    AutoRoute(path: '/products', page: ProductsScreenRoute.page),
    if (kDebugMode) AutoRoute(path: '/logs', page: LogScreenRoute.page),
  ];
}

@Riverpod(keepAlive: true)
// ignore: unsupported_provider_value
AppRouter appRouter(Ref ref) {
  return AppRouter(ref: ref);
}

class AuthGuard extends AutoRouteGuard {
  final Ref ref;
  AuthGuard({required this.ref});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final localCache = ref.read(localCacheProvider);
    final authenticated = (await localCache.getToken()) != "";

    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (router.currentPath != OnboardingScreenRoute.name && !authenticated) {
      resolver.next(true);
    } else if (authenticated) {
      resolver.redirect(HomeScreenRoute());
    }
  }
}
