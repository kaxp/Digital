import 'package:flutter_base_template_1/modules/home/models/home_events_response.dart';
import 'package:flutter_base_template_1/networking/retrofit/home_api_client.dart';

class HomeRepo {
  final HomeApiClient _homeApiClient = HomeApiClient.withAuthenticatedDio();

  Future<HomeEventsResponse> getEventByEventId({required int eventId}) async {
    return _homeApiClient.getEventByEventId(eventId);
  }
}
