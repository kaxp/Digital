part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({
    this.events = const [],
    this.searchQuery,
    this.page = 1,
    this.hasReachedEnd = true,
    this.totalPage = 1,
  });

  final List<Event> events;
  final String? searchQuery;
  final int page;
  final bool hasReachedEnd;
  final int totalPage;

  @override
  List<Object?> get props => [events, searchQuery, page, hasReachedEnd, totalPage];
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
    required int totalPage,
  }) : super(
          events: events,
          searchQuery: searchQuery,
          hasReachedEnd: hasReachedEnd,
          page: page,
          totalPage: totalPage,
        );
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required List<Event> events,
    required String searchQuery,
    required int page,
    required bool hasReachedEnd,
    required int totalPage,
  }) : super(
          events: events,
          searchQuery: searchQuery,
          hasReachedEnd: hasReachedEnd,
          page: page,
          totalPage: totalPage,
        );
}

class HomeError extends HomeState {
  const HomeError({
    required this.errorMessage,
    required List<Event> events,
    required String searchQuery,
    required int page,
    required bool hasReachedEnd,
    required int totalPage,
  }) : super(
          events: events,
          searchQuery: searchQuery,
          hasReachedEnd: hasReachedEnd,
          page: page,
          totalPage: totalPage,
        );

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
