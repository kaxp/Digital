import 'package:flutter/material.dart' hide MetaData;
import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/detail/bloc/detail_bloc.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/home_module.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import '../../../mocks/bloc/mock_blocs.mocks.dart';
import '../../../mocks/models/test_models_builder.dart';
import '../../../mocks/services/mock_services.mocks.dart';

final _defaultFavouriteEvent = buildStoreEventFromTemplate(
  id: 1,
  datetimeLocal: DateTime.now(),
  isFavourite: true,
  performers: [],
  title: 'My favourite event',
  venue: const Venue(city: 'City 1', state: 'State 1'),
);

final _defaultUnFavouriteEvent = buildStoreEventFromTemplate(
  id: 2,
  datetimeLocal: DateTime.now(),
  isFavourite: false,
  performers: [],
  title: 'My favourite event',
  venue: const Venue(city: 'City 1', state: 'State 1'),
);

void main() async {
  await S.load(const Locale.fromSubtags(languageCode: 'en')); // mimic localization delegate init

  late MockHomeBloc _mockHomeBloc;
  late MockDetailBloc _mockDetailBloc;
  late MockSharedPreferencesManager _mockSharedPreferencesManager;

  setUpAll(() {
    FlavorConfig(
      flavor: Flavor.mock,
      values: const FlavorValues(
        baseUrl: '',
        clientId: '',
      ),
    );
    _mockHomeBloc = MockHomeBloc();
    _mockDetailBloc = MockDetailBloc();
    _mockSharedPreferencesManager = MockSharedPreferencesManager();
  });

  setUp(() async {
    initModule(HomeModule(), replaceBinds: [
      Bind<HomeBloc>((_) => _mockHomeBloc),
      Bind<DetailBloc>((_) => _mockDetailBloc),
      Bind.lazySingleton<SharedPreferencesManager>(
        (_) => _mockSharedPreferencesManager,
      ),
    ]);
  });

  group('set initial state of detail page', () {
    test('''Given setInitialPageState method is called and state is DetailInitial
            When value of event.isFavorite is true
            Then state should change to DetailFavourite''', () async {
      final bloc = DetailBloc();

      bloc.setInitialPageState(_defaultFavouriteEvent);

      expect(bloc.state, isA<DetailFavourite>());
    });

    test('''Given setInitialPageState method is called and state is DetailInitial
            When value of event.isFavorite is false
            Then state should change to DetailUnFavourite''', () async {
      final bloc = DetailBloc();

      bloc.setInitialPageState(_defaultUnFavouriteEvent);

      expect(bloc.state, isA<DetailUnFavourite>());
    });
  });

  group('When favourite button is tapped', () {
    test('''Given onFavouriteTap method is called 
            When state is DetailUnFavourite
            Then the value should be added to Shared Prefs
            And state should change to DetailFavourite''', () async {
      final bloc = DetailBloc();

      final favouriteEvents =
          _mockSharedPreferencesManager.getStringList(SharedPreferencesKeys.favouriteEvents) ?? <String>[];
      favouriteEvents.add(_defaultFavouriteEvent.id.toString());

      when(_mockSharedPreferencesManager.setStringList(SharedPreferencesKeys.favouriteEvents, favouriteEvents))
          .thenAnswer((_) async => true);

      bloc.setInitialPageState(_defaultFavouriteEvent);
      bloc.onFavouriteTap(_defaultFavouriteEvent);

      expect(bloc.state, isA<DetailFavourite>());
    });

    test('''Given onFavouriteTap method is called 
            When state is DetailFavourite
            Then the value should be removed from Shared Prefs
            And state should change to DetailUnFavourite''', () async {
      final bloc = DetailBloc();

      final favouriteEvents =
          _mockSharedPreferencesManager.getStringList(SharedPreferencesKeys.favouriteEvents) ?? <String>[];
      favouriteEvents.remove(_defaultUnFavouriteEvent.id.toString());

      when(_mockSharedPreferencesManager.setStringList(SharedPreferencesKeys.favouriteEvents, favouriteEvents))
          .thenAnswer((_) async => true);

      bloc.setInitialPageState(_defaultUnFavouriteEvent);
      bloc.onFavouriteTap(_defaultUnFavouriteEvent);

      expect(bloc.state, isA<DetailUnFavourite>());
    });
  });
}
