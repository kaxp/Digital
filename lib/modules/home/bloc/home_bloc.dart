import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/modules/home/repositories/home_repo.dart';
import 'package:flutter_base_template_1/utils/dio_error_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());
  final _homeRepo = Modular.get<HomeRepo>();

  Future<void> fetchEvents(String? searchString) async {
    if (searchString == null || searchString.length <= 2) {
      emit(
        HomeLoaded(
          events: state.events,
          searchQuery: state.searchQuery!,
          hasReachedEnd: state.hasReachedEnd,
          page: state.page,
          totalResultCount: state.totalResultCount,
        ),
      );
      return;
    }

    try {
      emit(HomeLoading());
      final response = await _homeRepo.fetchEvents(
        searchString: searchString,
        page: state.page,
      );

      if (response.events.isNotEmpty) {
        emit(
          HomeLoaded(
            events: response.events,
            searchQuery: searchString,
            page: response.meta.page,
            hasReachedEnd: response.meta.total - 10 <=
                0, // when (total_result_count - 10 <= 0) == true, means we are at last page.
            totalResultCount: response.meta.total,
          ),
        );
      } else {
        emit(HomeEmpty());
      }
    } on DioError catch (error) {
      emit(HomeError(errorMessage: error.errorMessage()));
    }
  }

  Future<void> loadNextPage(String? searchString) async {
    if (state.hasReachedEnd || state is! HomeLoaded || state is HomeLoadingMore) {
      return;
    }

    try {
      emit(HomeLoadingMore(
        events: state.events,
        searchQuery: state.searchQuery!,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalResultCount: state.totalResultCount,
      ));

      final response = await _homeRepo.fetchEvents(
        searchString: searchString!,
        page: state.page + 1,
      );

      emit(
        HomeLoaded(
            events: state.events + response.events,
            searchQuery: searchString,
            page: response.meta.page,
            hasReachedEnd:
                response.meta.total - 10 <= 0, // when (total_result - 10 <= 0) == true, means we are at last page.
            totalResultCount:
                state.totalResultCount - 10 // Reduce the total result count by 10 with each pagination API call.
            ),
      );
    } on DioError catch (error) {
      emit(HomeError(errorMessage: error.errorMessage()));
    }
  }
}
