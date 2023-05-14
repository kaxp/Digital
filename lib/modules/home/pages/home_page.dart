import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = Modular.get<HomeBloc>();
  String? message;

  @override
  void initState() {
    super.initState();
    _homeBloc.getEventByEventId();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is HomeLoaded) {
          message = 'Data fetching is successful';
        } else if (state is HomeError) {
          message = state.errorMessage;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.current.homePage,
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Text(message ?? ''),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      DetailRoute.moduleRoute,
                    );
                  },
                  child: Text(
                    S.current.navigateToDetailPage,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
