import 'package:flutter_base_template_1/modules/detail/bloc/detail_bloc.dart';
import 'package:flutter_base_template_1/modules/detail/pages/detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<DetailBloc>((i) {
          return DetailBloc();
        }),
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
