import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/modules/detail/pages/detail_page.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils/init_test_module_helper.dart';

//TODO(kaxp): Add widget test for detail_page.

final defaultEvent = Event(
  id: 1,
  isFavourite: true,
  performers: const [
    Performer(
      id: 1,
      image: '',
      images: Images(huge: ''),
    ),
  ],
  datetimeLocal: DateTime.now(),
  title: 'Some title',
  venue: const Venue(city: 'City 1', state: 'State 1'),
);
void main() {
  setUpAll(() {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        baseUrl: '',
        clientId: '',
      ),
    );
  });

  setUp(() async {
    await initTestAppModule(replaceBinds: []);
  });

  testWidgets('''Given DetailPage is first opened
    Then DetailPage is rendered as expected''', (tester) async {
    await tester.pumpWidget(
      TestApp(
        child: DetailPage(
          event: defaultEvent,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CustomAppBar), findsOneWidget);
    //TODO(kaxp): Add widget test.
  });
}
