part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState({
    this.eventsData,
    this.searchQuery,
  });

  final EventsResponse? eventsData;
  final String? searchQuery;

  @override
  List<Object?> get props => [eventsData, searchQuery];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoaded extends SearchState {
  const SearchLoaded({
    EventsResponse? eventsData,
    String? searchQuery,
  }) : super(
          eventsData: eventsData,
          searchQuery: searchQuery,
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
