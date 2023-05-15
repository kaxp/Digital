import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/main_base.dart';
import 'package:flutter_base_template_1/networking/constants/network_constants.dart';

void main() async {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.mock,
      values: FlavorValues(
        baseUrl: NetworkConstants.mockServerUrl,
        clientId: NetworkConstants.mockServerClientId,
      ),
    ),
    dumpErrorToConsole: false,
  );
}