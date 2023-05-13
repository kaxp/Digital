import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.detailPage,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Modular.to.pushNamed(
              HomeRoute.moduleRoute,
            );
          },
          child: Text(
            S.current.backToHome,
          ),
        ),
      ),
    );
  }
}
