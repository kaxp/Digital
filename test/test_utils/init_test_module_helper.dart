import 'package:flutter_base_template_1/modules/app/base_app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

/// Initialize BaseAppModule for unit and widget testing
Future<BaseAppModule> initTestAppModule() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final module = BaseAppModule();

  Modular.init(module);
  return module;
}
