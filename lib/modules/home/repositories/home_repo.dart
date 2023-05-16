import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/networking/retrofit/home_api_client.dart';

class HomeRepo {
  final HomeApiClient _homeApiClient = HomeApiClient.withDefaultDio();

  Future<EventsResponse> fetchEventsData({
    required String searchString,
    required int page,
  }) async {
    return _homeApiClient.getEventsData(
      search: searchString,
      page: page,
    );
  }
}
