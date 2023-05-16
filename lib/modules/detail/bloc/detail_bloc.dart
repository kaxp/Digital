import 'package:equatable/equatable.dart';
import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'detail_state.dart';

class DetailBloc extends Cubit<DetailState> {
  DetailBloc() : super(DetailInitial());

  final _homeBloc = Modular.get<HomeBloc>();
  final _sharedPrefs = Modular.get<SharedPreferencesManager>();

  void setInitialPageState(Event event) {
    if (event.isFavourite) {
      emit(DetailFavourite());
    } else {
      emit(DetailUnFavourite());
    }
  }

  void onFavouriteTap(Event event) async {
    await _saveFavouriteEvents(event);
    _homeBloc.updateFavouriteEventStatus(event.id);

    if (state is DetailUnFavourite) {
      emit(DetailFavourite());
    } else {
      emit(DetailUnFavourite());
    }
  }

  Future<void> _saveFavouriteEvents(Event event) async {
    final favouriteEvents = _sharedPrefs.getStringList(SharedPreferencesKeys.favouriteEvents) ?? <String>[];
    favouriteEvents.add(event.id.toString());

    await _sharedPrefs.setStringList(SharedPreferencesKeys.favouriteEvents, favouriteEvents);
  }
}
