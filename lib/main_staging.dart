import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'main_base.dart';

void main() async {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.staging,
      values: const FlavorValues(
        baseUrl: '',
        authorization: '',
      ),
    ),
    dumpErrorToConsole: true,
  );
}
