import 'package:equatable/equatable.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'detail_state.dart';

class DetailBloc extends Cubit<DetailState> {
  DetailBloc() : super(DetailInitial());

  final _homeBloc = Modular.get<HomeBloc>();

  void setInitialPageState(Event event) {
    if (event.isFavourite) {
      emit(DetailFavourite());
    } else {
      emit(DetailUnFavourite());
    }
  }

  void onFavouriteTap(Event event) {
    _homeBloc.updateFavouriteEventStatus(event.id);

    // TODO(kaxp): Save this data to SharedPrefs.
    if (state is DetailUnFavourite) {
      emit(DetailFavourite());
    } else {
      emit(DetailUnFavourite());
    }
  }
}
