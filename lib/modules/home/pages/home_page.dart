import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header2.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/organisms/list_views/events_list_view.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_images.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_base_template_1/modules/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = Modular.get<HomeBloc>();
  String? message;

  @override
  void initState() {
    super.initState();
    _homeBloc.getEventByEventId();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is HomeLoaded) {
          message = 'Data fetching is successful';
        } else if (state is HomeError) {
          message = state.errorMessage;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            titleWidget: Text(
              S.current.homePage,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: AppFonts.ratMedium,
              ),
            ),
            isCenter: true,
            leadingWidget: const Center(
              child: Image(
                width: kSpacingXLarge,
                height: kSpacingXLarge,
                image: AssetImage(
                  AppImages.appLogo,
                ),
              ),
            ),
            actionWidgets: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  kSpacingMedium,
                  kSpacingMedium,
                  kSpacingMedium,
                  kSpacingZero,
                ),
                child: Header2(
                  title: S.current.myFavouriteEvents,
                  fontFamily: AppFonts.ratBold,
                  fontWeight: FontWeight.w700,
                ),
              ),
              EventsListView(
                isFavorite: true,
                onTap: () {
                  Modular.to.pushNamed(
                    DetailRoute.moduleRoute,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
