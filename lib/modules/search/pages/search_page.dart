import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header2.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/loading_overlay/loading_overlay.dart';
import 'package:flutter_base_template_1/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:flutter_base_template_1/components/molecules/snackbar/custom_snackbar.dart';
import 'package:flutter_base_template_1/components/organisms/list_views/events_list_view.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/search/bloc/search_bloc.dart';
import 'package:flutter_base_template_1/modules/search/models/events_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchFocus = FocusNode();
  Timer? _timer;
  final _searchBloc = Modular.get<SearchBloc>();
  String? searchQuery;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchFocus.requestFocus();
    _scrollController = ScrollController();
    _scrollController.addListener(_onEventListScrolledListener);
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: CustomSearchInputBox(
          hintText: S.current.searchEvents,
          onChanged: _onQueryChanged,
          focusNode: _searchFocus,
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        bloc: _searchBloc,
        listener: (context, state) {
          if (state is SearchError) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar(
                message: state.errorMessage,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sentiment_very_satisfied_outlined,
                  ),
                  Header2(
                    textAlign: TextAlign.center,
                    title: S.current.searchForEvents,
                  ),
                ],
              ),
            );
          } else if (state is SearchEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sentiment_very_dissatisfied_rounded,
                  ),
                  Header2(
                    textAlign: TextAlign.center,
                    title: S.current.noResultFound,
                  ),
                ],
              ),
            );
          }

          return LoadingOverlay(
            isLoading: state is SearchLoading,
            child: ListView(
              controller: _scrollController,
              children: [
                BuildSearchResultList(events: state.events),
                if (state is SearchLoadingMore)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(kSpacingMedium),
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onQueryChanged(String query) {
    searchQuery = query;
    _debounce(const Duration(milliseconds: 500), () {
      _searchBloc.fetchEvents(query);
    });
  }

  void _debounce(Duration duration, void Function() callback) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(duration, callback);
  }

  void _onEventListScrolledListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _searchBloc.loadNextPage(searchQuery);
    }
  }
}

class BuildSearchResultList extends StatelessWidget {
  const BuildSearchResultList({
    Key? key,
    required this.events,
  }) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return EventsListView(
      events: events,
    );
  }
}
