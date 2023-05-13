import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_base_template_1/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseAppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          BaseAppModuleRoutes.homePage,
          module: HomeModule(),
        ),
        ModuleRoute(
          BaseAppModuleRoutes.detailPage,
          module: DetailModule(),
        ),
      ];
}

class BaseAppModuleRoutes {
  static const String homePage = '/';
  static const String detailPage = '/detail';
}
