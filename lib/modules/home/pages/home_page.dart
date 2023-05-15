import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header2.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/loading_overlay/loading_overlay.dart';
import 'package:flutter_base_template_1/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:flutter_base_template_1/components/molecules/snackbar/custom_snackbar.dart';
import 'package:flutter_base_template_1/components/organisms/list_views/events_list_view.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_images.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchFocus = FocusNode();
  Timer? _timer;
  final _homeBloc = Modular.get<HomeBloc>();
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
        leadingWidget: const Center(
          child: Image(
            width: kSpacingXLarge,
            height: kSpacingXLarge,
            image: AssetImage(
              AppImages.appLogo,
            ),
          ),
        ),
        titleWidget: CustomSearchInputBox(
          hintText: S.current.searchEvents,
          onChanged: _onQueryChanged,
          focusNode: _searchFocus,
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar(
                message: state.errorMessage,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeInitial) {
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
          } else if (state is HomeEmpty) {
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
            isLoading: state is HomeLoading,
            child: ListView(
              controller: _scrollController,
              children: [
                EventsListView(
                  events: state.events,
                ),
                if (state is HomeLoadingMore)
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
      _homeBloc.fetchEvents(query);
    });
  }

  void _debounce(Duration duration, void Function() callback) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(duration, callback);
  }

  void _onEventListScrolledListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _homeBloc.loadNextPage(searchQuery);
    }
  }
}
