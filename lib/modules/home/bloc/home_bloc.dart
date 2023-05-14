import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_template_1/modules/home/repositories/home_repo.dart';
import 'package:flutter_base_template_1/utils/dio_error_extension.dart';
import 'package:flutter_base_template_1/utils/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());

  final _repo = Modular.get<HomeRepo>();

  Future<void> getEventByEventId() async {
    try {
      final result = await _repo.getEventByEventId(eventId: 6009891);

      Log.debug('$result');
    } on DioError catch (e) {
      Log.error('$e');
      emit(
        HomeError(errorMessage: e.errorMessage()),
      );
    }
  }
}
