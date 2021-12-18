import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiet/component.dart';
import 'package:quiet/pages/account/account.dart';

class QuietApp extends ConsumerWidget {
  const QuietApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      routes: routes,
      onGenerateRoute: routeFactory,
      title: 'Quiet',
      supportedLocales: const [Locale("en"), Locale("zh")],
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: context.settings.theme,
      darkTheme: context.settings.darkTheme,
      themeMode: context.settings.themeMode,
      initialRoute: getInitialRoute(
        ref,
        skipWelcomePage: context.settings.skipWelcomePage,
      ),
    );
  }

  String getInitialRoute(WidgetRef ref, {required bool skipWelcomePage}) {
    if (defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux) {
      return pageDesktopMain;
    }
    final bool login = ref.read(isLoginProvider);

    if (!login && !skipWelcomePage) {
      return pageWelcome;
    }
    return pageMain;
  }
}
