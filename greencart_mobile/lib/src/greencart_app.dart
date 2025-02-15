import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/core/core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:toastification/toastification.dart';

class GreenCartApp extends ConsumerWidget {
  const GreenCartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final talker = ref.watch(talkerLoggerProvider);
    final themeMode = ref.watch(appThemeModeControllerProvider);

    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'GreenCart'.hardcoded,
        themeMode: themeMode,
        routerConfig: router.config(
          navigatorObservers:
              () => [
                if (kDebugMode) TalkerRouteObserver(talker),
                SentryNavigatorObserver(),
              ],
        ),
        theme: AppThemeData(AppTheme.light()).themeData,
        darkTheme: AppThemeData(AppTheme.dark()).themeData,
        builder: (context, route) {
          return route!;
        },
      ),
    );
  }
}
