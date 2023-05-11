import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/modules/app/base_app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Modular.to.navigate(BaseAppModuleRoutes.detailPage),
          child: const Text('Navigate to Detail Page'),
        ),
      ),
    );
  }
}
