part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({
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

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeEmpty extends HomeState {}

// Pagination loading
class HomeLoadingMore extends HomeState {
  const HomeLoadingMore({
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

class HomeLoaded extends HomeState {
  const HomeLoaded({
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

class HomeError extends HomeState {
  const HomeError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
