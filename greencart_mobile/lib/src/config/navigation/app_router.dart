import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      page: OnboardingScreenRoute.page,
      path: '/onboarding',
    ),
    if (kDebugMode)
      AutoRoute(
        page: LogScreenRoute.page,
        path: '/logs',
      ),
  ];
}

@Riverpod(keepAlive: true)
// ignore: unsupported_provider_value
AppRouter appRouter(Ref ref) {
  return AppRouter(ref: ref);
}
