import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base_template_1/managers/shared_preferences_manager.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/modules/home/repositories/home_repo.dart';
import 'package:flutter_base_template_1/utils/dio_error_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());
  final _homeRepo = Modular.get<HomeRepo>();
  final _sharedPrefs = Modular.get<SharedPreferencesManager>();

  Future<void> fetchEvents(String? searchString) async {
    if (searchString == null || searchString.length <= 2) {
      emit(
        HomeLoaded(
          events: state.events,
          searchQuery: state.searchQuery!,
          hasReachedEnd: state.hasReachedEnd,
          page: state.page,
          totalPage: state.totalPage,
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
        await _fetchSavedFavouriteEvents(response);

        emit(
          HomeLoaded(
            events: response.events,
            searchQuery: searchString,
            page: response.meta.page,
            hasReachedEnd: response.meta.total - 10 <=
                0, // when (total_result_count - 10 <= 0) == true, means we are at last page.
            totalPage: response.meta.total,
          ),
        );
      } else {
        emit(HomeEmpty());
      }
    } on DioError catch (error) {
      emit(
        HomeError(
          errorMessage: error.errorMessage(),
          events: state.events,
          hasReachedEnd: state.hasReachedEnd,
          page: state.page,
          totalPage: state.totalPage,
          searchQuery: searchString,
        ),
      );
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
        totalPage: state.totalPage,
      ));

      final response = await _homeRepo.fetchEvents(
        searchString: searchString!,
        page: state.page + 1,
      );

      await _fetchSavedFavouriteEvents(response);

      emit(
        HomeLoaded(
            events: state.events + response.events,
            searchQuery: searchString,
            page: response.meta.page,
            hasReachedEnd:
                response.meta.total - 10 <= 0, // when (total_result - 10 <= 0) == true, means we are at last page.
            totalPage: state.totalPage - 10 // Reduce the total result count by 10 with each pagination API call.
            ),
      );
    } on DioError catch (error) {
      emit(
        HomeError(
          errorMessage: error.errorMessage(),
          events: state.events,
          hasReachedEnd: state.hasReachedEnd,
          page: state.page,
          totalPage: state.totalPage,
          searchQuery: searchString!,
        ),
      );
    }
  }

  void updateFavouriteEventStatus(int eventId) {
    final event = state.events.firstWhere((element) => element.id == eventId);
    event.isFavourite = !event.isFavourite;
    emit(
      HomeLoaded(
        events: state.events,
        searchQuery: state.searchQuery!,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<void> _fetchSavedFavouriteEvents(EventsResponse response) async {
    final favEventsListInString = _sharedPrefs.getStringList(SharedPreferencesKeys.favouriteEvents) ?? <String>[];

    final favEventsListInInt = favEventsListInString.map((i) => int.parse(i)).toList();

    for (var event in response.events) {
      if (favEventsListInInt.contains(event.id)) {
        event.isFavourite = true;
      }
    }
  }
}
