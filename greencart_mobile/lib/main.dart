import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greencart_app/src/config/config.dart';
import 'package:greencart_app/src/greencart_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final container = ProviderContainer(
    observers: [
      if (kDebugMode)
        TalkerRiverpodObserver(
          talker: talkerFlutter,
          settings: TalkerRiverpodLoggerSettings(printProviderDisposed: true),
        ),
    ],
  );

  // Initialize Sentry
  await SentryFlutter.init((options) {
    options.dsn = Env.sentryDSN;
    // Improve stack traces in the dashboard
    options
      ..considerInAppFramesByDefault = false
      ..addInAppInclude('greencart_app');
    options.beforeSend = (SentryEvent event, Hint hint) async {
      container
          .read(talkerLoggerProvider)
          .debug("Sentry event: ${event.toJson()}");
      // Ignore events that are not from release builds
      if (!kReleaseMode) {
        return null;
      }
      // If there was no response, it means that a connection error occurred. Do not log this to Sentry
      final exception = event.throwable;
      if (exception is DioException && exception.response == null) {
        return null;
      }
      // For all other events, return the event as is
      return event;
    };
  });

  await container.read(sharedPreferencesProvider.future);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const GreenCartApp(),
    ),
  );
}
