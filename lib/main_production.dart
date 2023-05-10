import 'package:flutter/foundation.dart';
import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'main_base.dart';

void main() async {
  // disable debug print on production release mode
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.production,
      values: const FlavorValues(
        baseUrl: '',
        authorization: '',
      ),
    ),
    dumpErrorToConsole: true,
  );
}
