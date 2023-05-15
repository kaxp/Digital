import 'package:flutter_base_template_1/modules/search/bloc/search_bloc.dart';
import 'package:flutter_base_template_1/modules/search/pages/search_page.dart';
import 'package:flutter_base_template_1/modules/search/repositories/search_repo.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<SearchRepo>((_) => SearchRepo()),
        Bind<SearchBloc>((i) {
          return SearchBloc();
        }),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SearchPage(),
        ),
      ];
}

class SearchRoute {
  static const String moduleRoute = '/search/';
}
