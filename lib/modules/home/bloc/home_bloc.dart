import 'dart:async';

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
  String? searchQuery;
  Timer? _timer;

  // HomeState getters
  HomeState get _loadedStateWithExistingAvailableData => HomeLoaded(
        events: state.events,
        searchQuery: state.searchQuery!,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
      );

  HomeState get _loadingMoreStateWithExistingAvailableData => HomeLoadingMore(
        events: state.events,
        searchQuery: state.searchQuery!,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
      );

  void _emitErrorStateWithExistingAvailableData({
    required String errorMessage,
    required String? searchQuery,
  }) {
    emit(
      HomeError(
        errorMessage: errorMessage,
        events: state.events,
        hasReachedEnd: state.hasReachedEnd,
        page: state.page,
        totalPage: state.totalPage,
        searchQuery: searchQuery!,
      ),
    );
  }

  /// [fetchEvents] method is used for fetching the event data
  /// on user search.
  Future<void> fetchEvents(String? searchString) async {
    if (searchString == null || searchString.length <= 2) {
      emit(_loadedStateWithExistingAvailableData);

      return;
    }

    try {
      emit(HomeLoading());
      final response = await _homeRepo.fetchEventsData(
        searchString: searchString,
        page: state.page,
      );

      if (response.events.isNotEmpty) {
        await _fetchSavedFavouriteEventsFromPrefs(response);

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
      _emitErrorStateWithExistingAvailableData(
        errorMessage: error.errorMessage(),
        searchQuery: searchString,
      );
    }
  }

  /// [loadNextPage] method is used for fetching the next available
  /// pagination data when user scroll to the bottom of screen.
  Future<void> loadNextPage(String? searchString) async {
    if (state.hasReachedEnd || state is! HomeLoaded || state is HomeLoadingMore) {
      return;
    }

    try {
      emit(_loadingMoreStateWithExistingAvailableData);

      final response = await _homeRepo.fetchEventsData(
        searchString: searchString!,
        page: state.page + 1,
      );
      await _fetchSavedFavouriteEventsFromPrefs(response);

      emit(
        HomeLoaded(
          events: state.events + response.events,
          searchQuery: searchString,
          page: response.meta.page,
          hasReachedEnd:
              response.meta.total - 10 <= 0, // when (total_result - 10 <= 0) == true, means we are at last page.
          totalPage: state.totalPage - 10, // Reduce the total result count by 10 with each pagination API call.
        ),
      );
    } on DioError catch (error) {
      _emitErrorStateWithExistingAvailableData(
        errorMessage: error.errorMessage(),
        searchQuery: searchString,
      );
    }
  }

  /// A helper method that is used to updating the status
  /// of event i.e favourite <=> unfavourite.
  void updateEventStatus(int eventId) {
    final event = state.events.firstWhere((element) => element.id == eventId);
    event.isFavourite = !event.isFavourite;
    emit(_loadedStateWithExistingAvailableData);
  }

  /// A helper method that is used for fetching the locally saved favourite
  /// events Ids in Shared Preferences.
  ///
  /// After fetching the saved favourite event id's, this method will check for
  /// the availablity of these id's in API response and will update the status of
  /// [isFavourite] key to true when matching ids are found in response.
  Future<void> _fetchSavedFavouriteEventsFromPrefs(EventsResponse response) async {
    final favEventsListInString = _sharedPrefs.getStringList(SharedPreferencesKeys.favouriteEvents) ?? <String>[];

    final favEventsListInInt = favEventsListInString.map((i) => int.parse(i)).toList();

    for (var event in response.events) {
      if (favEventsListInInt.contains(event.id)) {
        event.isFavourite = true;
      }
    }
  }

  void onQueryChanged(String query) {
    searchQuery = query;
    _debounce(const Duration(milliseconds: 500), () {
      fetchEvents(query);
    });
  }

  void _debounce(Duration duration, void Function() callback) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(duration, callback);
  }
}
