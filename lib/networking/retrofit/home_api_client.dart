import 'package:dio/dio.dart';
import 'package:flutter_base_template_1/modules/home/models/home_events_response.dart';
import 'package:flutter_base_template_1/networking/constants/network_constants.dart';
import 'package:flutter_base_template_1/networking/models/app_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@RestApi()
abstract class HomeApiClient {
  factory HomeApiClient.withAuthenticatedDio({String? baseUrl}) {
    return HomeApiClient(
      Modular.get<AppDio>().noAuthDio,
      baseUrl: NetworkConstants.baseUrl,
    );
  }

  factory HomeApiClient(Dio dio, {String? baseUrl}) {
    return _HomeApiClient(
      dio,
      baseUrl: NetworkConstants.baseUrl,
    );
  }

 @GET('/events/{eventId}')
  Future<HomeEventsResponse> getEventByEventId(
    @Path('eventId') int eventId,
  );
}


