import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SharedPreferencesManager>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {}
