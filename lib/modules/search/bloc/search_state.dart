part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState({
    this.events = const [],
    this.searchQuery,
    this.page = 1,
    this.hasReachedEnd = true,
    this.totalResultCount = 10,
  });

  final List<Event> events;
  final String? searchQuery;
  final int page;
  final bool hasReachedEnd;
  final int totalResultCount;

  @override
  List<Object?> get props => [events, searchQuery, page, hasReachedEnd, totalResultCount];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchEmpty extends SearchState {}

// Pagination loading
class SearchLoadingMore extends SearchState {
  const SearchLoadingMore({
    required List<Event> events,
    required String searchQuery,
    required int page,
    required bool hasReachedEnd,
    required int totalResultCount,
  }) : super(
          events: events,
          searchQuery: searchQuery,
          hasReachedEnd: hasReachedEnd,
          page: page,
          totalResultCount: totalResultCount,
        );
}

class SearchLoaded extends SearchState {
  const SearchLoaded({
    required List<Event> events,
    required String searchQuery,
    required int page,
    required bool hasReachedEnd,
    required int totalResultCount,
  }) : super(
          events: events,
          searchQuery: searchQuery,
          hasReachedEnd: hasReachedEnd,
          page: page,
          totalResultCount: totalResultCount,
        );
}

class SearchError extends SearchState {
  const SearchError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
