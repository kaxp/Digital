import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/modules/app/base_app_module.dart';
import 'package:flutter_base_template_1/modules/app/root_app.dart';
import 'package:flutter_modular/flutter_modular.dart';

void runMain({
  required FlavorConfig Function() configInit,
  required bool dumpErrorToConsole,
}) async {
  runZonedGuarded<Future<void>>(() async {
    await _init(configInit: configInit);

    runApp(
      ModularApp(
        module: BaseAppModule(),
        child: const RootApp(),
      ),
    );
  }, (error, stack) {
    final details = FlutterErrorDetails(exception: error, stack: stack);
    if (dumpErrorToConsole) {
      FlutterError.dumpErrorToConsole(details);
    }
    // Record errors to analytics here, like FirebaseCrashlytics etc.
  });
}

/// A Helper method that is used for initialise app services like
/// firebase, remote config, or other 3rd party SDK dependences etc.
/// All the services that needs to be initialised at the start of the app
/// will be added here.
Future<void> _init({
  required FlavorConfig Function() configInit,
}) async {
  // initialize widget binding
  WidgetsFlutterBinding.ensureInitialized();

  // init flavors specific values
  configInit();
}
