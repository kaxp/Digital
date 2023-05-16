import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/search_input_box/custom_search_input_box.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_images.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/widgets/home_main_body_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchQuery;
  Timer? _timer;
  final _searchFocus = FocusNode();
  final _homeBloc = Modular.get<HomeBloc>();
  late final ScrollController _scrollController;
  late final TextEditingController _searchInputController;

  @override
  void initState() {
    super.initState();
    _searchFocus.requestFocus();
    _scrollController = ScrollController();
    _scrollController.addListener(_onEventListScrolledListener);
    _searchInputController = TextEditingController();
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _scrollController.dispose();
    _searchInputController.dispose();
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
          controller: _searchInputController,
          showSuffixIcon: true,
        ),
      ),
      body: HomeMainBodyView(
        homeBloc: _homeBloc,
        scrollController: _scrollController,
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
    if (_scrollController.position.pixels <= _scrollController.position.maxScrollExtent * 0.8) {
      // When textinput is empty we don't want to call paging API
      if (_searchInputController.text.length > 0) {
        _homeBloc.loadNextPage(searchQuery);
      }
    }
  }
}
