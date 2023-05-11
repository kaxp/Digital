import 'package:flutter_base_template_1/main.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseAppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        // TODO(kaxp): Update the ChildRoute to ModuleRoute in follow-up PR.
        ChildRoute(
          BaseAppModuleRoutes.homePage,
          child: (context, args) => HomePage(),
        ),
        ChildRoute(BaseAppModuleRoutes.detailPage, child: (context, args) => SecondPage()),
      ];
}

class BaseAppModuleRoutes {
  static const String homePage = '/';
  static const String detailPage = '/home';
}
