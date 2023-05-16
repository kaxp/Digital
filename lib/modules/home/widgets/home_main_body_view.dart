import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/molecules/loading_overlay/loading_overlay.dart';
import 'package:flutter_base_template_1/components/molecules/snackbar/custom_snackbar.dart';
import 'package:flutter_base_template_1/components/organisms/list_views/events_list_view.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_base_template_1/modules/home/widgets/home_empty_view.dart';
import 'package:flutter_base_template_1/modules/home/widgets/home_initial_view.dart';
import 'package:flutter_base_template_1/modules/home/widgets/home_paging_loading_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMainBodyView extends StatelessWidget {
  const HomeMainBodyView({
    super.key,
    required this.homeBloc,
    required this.scrollController,
  });

  final HomeBloc homeBloc;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
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
          return const HomeInitialView();
        } else if (state is HomeEmpty) {
          return const HomeEmptyView();
        }

        return LoadingOverlay(
          isLoading: state is HomeLoading,
          child: ListView(
            controller: scrollController,
            children: [
              state.events.isNotEmpty
                  ? EventsListView(
                      events: state.events,
                    )
                  : const HomeInitialView(),

              // Pagination loader
              if (state is HomeLoadingMore) const HomePagingLoadingView(),
            ],
          ),
        );
      },
    );
  }
}
