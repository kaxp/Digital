import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  IModularNavigator,
], customMocks: [
  MockSpec<SharedPreferencesManager>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {}
