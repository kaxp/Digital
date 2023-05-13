import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
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
