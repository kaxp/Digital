import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_base_template_1/modules/home/home_module.dart';
import 'package:flutter_base_template_1/networking/constants/network_constants.dart';
import 'package:flutter_base_template_1/networking/http_client.dart';
import 'package:flutter_base_template_1/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BaseAppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<AppDio>(
          (i) => AppDio(
            noAuthDio: defaultHttpClient(
              clientId: NetworkConstants.clientId,
            ),
          ),
        ),
        Bind.lazySingleton<SharedPreferencesManager>((i) {
          return SharedPreferencesManager();
        })
      ];

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
  static const String detailPage = '/detail/';
}
