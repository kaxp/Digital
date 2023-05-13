import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_base_template_1/modules/home/repositories/home_repo.dart';
import 'package:flutter_base_template_1/utils/log.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeRepo _homeRepo = HomeRepo();

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  Future<void> _getEvent() async {
    try {
      final result = await _homeRepo.getEventByEventId();

      Log.debug('$result');
    } catch (e) {
      Log.error('$e');
      // never swallow unhandled error
      rethrow;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.homePage,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Modular.to.pushNamed(
              DetailRoute.moduleRoute,
            );
          },
          child: Text(
            S.current.navigateToDetailPage,
          ),
        ),
      ),
    );
  }
}
