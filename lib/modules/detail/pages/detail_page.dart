import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
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
          onPressed: () => Modular.to.navigate('/'),
          child: Text(
            S.current.backToHome,
          ),
        ),
      ),
    );
  }
}
