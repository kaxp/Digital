import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/app/base_app_module.dart';
import 'package:flutter_base_template_1/modules/detail/bloc/detail_bloc.dart';
import 'package:flutter_base_template_1/modules/detail/pages/detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailModule extends BaseAppModule {
  @override
  List<Bind> get binds => [
        Bind<DetailBloc>((i) {
          return DetailBloc();
        }),
        Bind.lazySingleton<SharedPreferencesManager>((i) {
          return SharedPreferencesManager();
        })
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => DetailPage(event: args.data),
        ),
      ];
}

class DetailRoute {
  static const String moduleRoute = '/detail/';
}
