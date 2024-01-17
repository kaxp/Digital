import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/app/base_app_module.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/pages/home_page.dart';
import 'package:flutter_base_template_1/modules/home/repositories/home_repo.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends BaseAppModule {
  @override
  List<Bind> get binds => [
        Bind<HomeRepo>((_) => HomeRepo()),
        Bind<HomeBloc>((_) => HomeBloc()),
        Bind.lazySingleton<SharedPreferencesManager>((i) {
          return SharedPreferencesManager();
        })
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const HomePage(),
        ),
      ];
}

class HomeRoute {
  static const String moduleRoute = '/';
}
