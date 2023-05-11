import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/constants/widget_keys.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RootApp extends StatelessWidget {
  const RootApp();

  static final RouteObserver<Route> routeObserver = RouteObserver<Route>();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: WidgetKeys.rootScaffoldMessengerKey,
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
      ],
    );
  }
}
