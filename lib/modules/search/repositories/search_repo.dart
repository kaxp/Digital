import 'package:flutter_base_template_1/modules/search/models/events_response.dart';
import 'package:flutter_base_template_1/networking/retrofit/search_api_client.dart';

class SearchRepo {
  final SearchApiClient _searchApiClient = SearchApiClient.withDefaultDio();

  Future<EventsResponse> fetchEvents({
    required String searchString,
    required int page,
  }) async {
    return _searchApiClient.getEventsData(
      search: searchString,
      page: page,
    );
  }
}
