import 'package:flutter/material.dart' hide MetaData;
import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/home_module.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/modules/home/repositories/home_repo.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import '../../../mocks/bloc/mock_blocs.mocks.dart';
import '../../../mocks/models/test_models_builder.dart';
import '../../../mocks/repositories/mock_repositories.mocks.dart';
import '../../../mocks/services/mock_services.mocks.dart';
import '../../../test_utils/mock_dio_error.dart';

EventsResponse _defaultEventsResponse() {
  return buildEventsResponseFromTemplate(
    events: [
      Event(
          id: 1,
          performers: const [Performer(id: 1, image: '', images: Images(huge: ''))],
          datetimeLocal: DateTime.now(),
          title: 'Some title',
          venue: const Venue(city: 'City 1', state: 'State 1')),
      Event(
          id: 1,
          performers: const [Performer(id: 1, image: '', images: Images(huge: ''))],
          datetimeLocal: DateTime.now(),
          title: 'Some title',
          venue: const Venue(city: 'City 1', state: 'State 1')),
    ],
    meta: const MetaData(total: 30, page: 1, perPage: 10),
  );
}

EventsResponse _defaultEmptyEventsResponse() {
  return buildEventsResponseFromTemplate(
    events: [],
    meta: const MetaData(total: 30, page: 1, perPage: 10),
  );
}

EventsResponse _defaultLastPageEventsResponse() {
  return buildEventsResponseFromTemplate(
    events: [
      Event(
          id: 1,
          performers: const [Performer(id: 1, image: '', images: Images(huge: ''))],
          datetimeLocal: DateTime.now(),
          title: 'Some title',
          venue: const Venue(city: 'City 1', state: 'State 1')),
      Event(
          id: 1,
          performers: const [Performer(id: 1, image: '', images: Images(huge: ''))],
          datetimeLocal: DateTime.now(),
          title: 'Some title',
          venue: const Venue(city: 'City 1', state: 'State 1')),
    ],
    meta: const MetaData(total: 10, page: 1, perPage: 10),
  );
}

void main() async {
  await S.load(const Locale.fromSubtags(languageCode: 'en')); // mimic localization delegate init

  late MockHomeBloc _mockHomeBloc;
  late MockSharedPreferencesManager _mockSharedPreferencesManager;
  late MockHomeRepo _mockHomeRepo;

  setUpAll(() {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        baseUrl: '',
        clientId: '',
      ),
    );
    _mockHomeRepo = MockHomeRepo();
    _mockHomeBloc = MockHomeBloc();
    _mockSharedPreferencesManager = MockSharedPreferencesManager();

    when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
        .thenAnswer((_) => Future.value(_defaultEventsResponse()));
  });

  setUp(() async {
    initModule(HomeModule(), replaceBinds: [
      Bind<HomeBloc>((_) => _mockHomeBloc),
      Bind<HomeRepo>((_) => _mockHomeRepo),
      Bind.lazySingleton<SharedPreferencesManager>(
        (_) => _mockSharedPreferencesManager,
      ),
    ]);
  });

  group('fetch event data from fetchEvents method', () {
    test('''Given fetchEvents() is called and state is HomeInitial
        When value of searchString is null 
        Then state should change to HomeLoaded with default data''', () async {
      final bloc = HomeBloc();
      await bloc.fetchEvents(null);

      expect(bloc.state, isA<HomeLoaded>());
    });

    test('''Given fetchEvents() is called and state is HomeInitial
        When searchString.length is less than 2
        Then state should change to HomeLoaded with default data''', () async {
      final bloc = HomeBloc();
      await bloc.fetchEvents('Hi');

      expect(bloc.state, isA<HomeLoaded>());
    });

    test('''Given fetchEvents() is called and state is HomeInitial
        When value of searchString is "Hello"
        And fetchEventsData method return the result
        Then state should change to HomeLoaded''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));

      await bloc.fetchEvents('Hello');
      expect(bloc.state, isA<HomeLoaded>());
    });

    test('''Given fetchEvents() is called and state is HomeInitial
        When value of searchString is "Hello"
        And fetchEventsData method return empty event list
        Then state should change to HomeEmpty''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEmptyEventsResponse()));

      await bloc.fetchEvents('Hello');
      expect(bloc.state, isA<HomeEmpty>());
    });

    test('''Given fetchEvents() is called and state is HomeInitial
        When value of searchString is "Hello"
        And fetchEventsData method throw DioError
        Then state should change to HomeError''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1)).thenAnswer(
        (_) async => throw MockDioError(),
      );

      await bloc.fetchEvents('Hello');
      expect(bloc.state, isA<HomeError>());
    });
  });

  group('fetch pagination data from loadNextPage method', () {
    test('''Given loadNextPage() is called and state is not HomeLoaded
        Then pagination should not happen and method should return''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1)).thenAnswer(
        (_) async => throw MockDioError(),
      );

      await bloc.fetchEvents('Hello');
      when(bloc.state is HomeError);

      await bloc.loadNextPage('Hello');

      verifyNever(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 2));
    });

    test('''Given loadNextPage() is called and state is HomeLoaded
        When last page of pagination is already fetched
        Then pagination should not happen and method should return''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultLastPageEventsResponse()));
      await bloc.fetchEvents('Hello');
      when(bloc.state is HomeLoaded);

      await bloc.loadNextPage('How are you');

      verifyNever(_mockHomeRepo.fetchEventsData(searchString: 'How are you', page: 2));
    });

    test('''Given loadNextPage() is called and state is HomeLoaded
         When value of searchString is "How are you" and page is 2
        And fetchEventsData method during pagination return the response
        Then state should change to HomeLoaded''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));
      await bloc.fetchEvents('Hello');
      when(bloc.state is HomeLoaded);

      when(_mockHomeRepo.fetchEventsData(searchString: 'How are you', page: 2))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));
      await bloc.loadNextPage('How are you');
      expect(bloc.state, isA<HomeLoaded>());
    });

    test('''Given loadNextPage() is called and state is HomeLoaded
        When value of searchString is "How are you" and page is 2
        And fetchEventsData method during pagination return empty event list
        Then state should stay in HomeLoaded''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));
      await bloc.fetchEvents('Hello');
      when(bloc.state is HomeLoaded);

      when(_mockHomeRepo.fetchEventsData(searchString: 'How are you', page: 2))
          .thenAnswer((_) => Future.value(_defaultEmptyEventsResponse()));
      await bloc.loadNextPage('How are you');

      expect(bloc.state, isA<HomeLoaded>());
    });

    test('''Given loadNextPage() is called and state is HomeLoaded
        When value of searchString is "How are you" and page is 2
        And fetchEventsData method during pagination return DioError
        Then state should change to HomeError''', () async {
      final bloc = HomeBloc();

      when(_mockHomeRepo.fetchEventsData(searchString: 'Hello', page: 1))
          .thenAnswer((_) => Future.value(_defaultEventsResponse()));
      await bloc.fetchEvents('Hello');
      when(bloc.state is HomeLoaded);

      when(_mockHomeRepo.fetchEventsData(searchString: 'How are you', page: 2)).thenAnswer(
        (_) async => throw MockDioError(),
      );
      await bloc.loadNextPage('How are you');

      expect(bloc.state, isA<HomeError>());
    });
  });
}
