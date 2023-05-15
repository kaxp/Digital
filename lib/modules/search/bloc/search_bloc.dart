import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_template_1/modules/search/repositories/search_repo.dart';
import 'package:flutter_base_template_1/utils/dio_error_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'search_state.dart';

class SearchBloc extends Cubit<SearchState> {
  SearchBloc() : super(SearchInitial());

  final _searchRepo = Modular.get<SearchRepo>();

  Future<void> fetchEvents(String? searchString) async {
    if (searchString == null || searchString.length <= 2) {
      emit(
        SearchLoaded(),
      );
      return;
    }

    try {
      await _searchRepo.fetchEvents(searchString);
      emit(
        SearchLoaded(),
      );
    } on DioError catch (error) {
      emit(SearchError(errorMessage: error.errorMessage()));
    }
  }
}
