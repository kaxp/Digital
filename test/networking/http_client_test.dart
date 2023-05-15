import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/init_test_module_helper.dart';

void main() {
  final expectedBaseParams = <String, dynamic>{
    'client_id': 'sample_client_id_for_mock',
  };

  setUpAll(() async {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        clientId: 'sample_client_id_for_mock',
        baseUrl: '',
      ),
    );
    await initTestAppModule();
  });

  test(
    '''Given the AppDio get bind into the BaseAppModule 
       When the appDio internal member noAuthDio get constructed 
       Then it should contains all the specific params
    ''',
    () async {
      final appDio = Modular.get<AppDio>();

      final paramKey = expectedBaseParams.keys;
      final paramValue = expectedBaseParams[paramKey];

      expect(appDio.noAuthDio.options.queryParameters[paramKey], paramValue);
    },
  );
}
