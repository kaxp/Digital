import 'package:flutter_base_template_1/modules/detail/pages/detail_page.dart';
import 'package:flutter_base_template_1/modules/home/pages/home_page.dart';
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
        ChildRoute(BaseAppModuleRoutes.detailPage, child: (context, args) => DetailPage()),
      ];
}

class BaseAppModuleRoutes {
  static const String homePage = '/';
  static const String detailPage = '/detail';
}
