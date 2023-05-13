import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/networking/constants/network_constants.dart';
import 'main_base.dart';

void main() async {
  runMain(
    configInit: () => FlavorConfig(
      flavor: Flavor.staging,
      values: FlavorValues(
        baseUrl: NetworkConstants.stagingBaseUrl,
        authorization: NetworkConstants.stagingAuthorization,
      ),
    ),
    dumpErrorToConsole: true,
  );
}
