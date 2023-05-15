import 'package:dio/dio.dart';
import 'package:flutter_base_template_1/modules/search/models/events_response.dart';
import 'package:flutter_base_template_1/networking/constants/network_constants.dart';
import 'package:flutter_base_template_1/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:retrofit/retrofit.dart';

part 'search_api_client.g.dart';

@RestApi()
abstract class SearchApiClient {
  factory SearchApiClient.withDefaultDio({String? baseUrl}) {
    return SearchApiClient(
      Modular.get<AppDio>().noAuthDio,
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  factory SearchApiClient(Dio dio, {String? baseUrl}) {
    return _SearchApiClient(
      dio,
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  @GET('/events')
  Future<EventsResponse> getEventsData(
    @Query('q') String? search,
  );
}
