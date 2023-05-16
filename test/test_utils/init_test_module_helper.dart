import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/app_theme.dart';
import 'package:flutter_base_template_1/constants/widget_keys.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/app/base_app_module.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

/// Initialize BaseAppModule for unit and widget testing
Future<BaseAppModule> initTestAppModule({
  List<Bind>? replaceBinds,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final module = BaseAppModule();
  WidgetsFlutterBinding.ensureInitialized();

  initModule(module, replaceBinds: [
    ...?replaceBinds,
  ]);

  Modular.init(module);
  return module;
}

/// TestApp for performing widget tests
///
/// Usage:
/// ```
///   testWidgets('description', (tester) async {
///    final appModule = await initTestAppModule();
///
///    await tester.pumpWidget(TestApp(child: SomePage()));
///
///    expect(find.text('Some text'), findsWidgets);
///  });
///
/// ```
class TestApp extends StatelessWidget {
  const TestApp({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter template',
      theme: AppTheme.defaultTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: WidgetKeys.rootScaffoldMessengerKey,
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
