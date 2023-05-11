import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Modular.to.navigate('/'),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}
