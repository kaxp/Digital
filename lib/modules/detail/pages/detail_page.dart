import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/detail/bloc/detail_bloc.dart';
import 'package:flutter_base_template_1/modules/detail/widgets/detail_main_body_view.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _detailBloc = Modular.get<DetailBloc>();

  @override
  void initState() {
    super.initState();
    _detailBloc.setInitialPageState(widget.event);
  }

  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      bloc: _detailBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            titleWidget: Text(
              S.current.detailPage,
              style: const TextStyle(
                color: AppColors.backgroundColor,
                fontFamily: AppFonts.ratMedium,
              ),
            ),
            isCenter: true,
            actionWidgets: [
              IconButton(
                onPressed: () => _detailBloc.onFavouriteTap(widget.event),
                icon: state is DetailFavourite
                    ? const Icon(
                        Icons.favorite,
                        color: AppColors.redColor,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      ),
              )
            ],
          ),
          body: DetailMainBodyView(
            imageUrl: widget.event.performers[0].image,
            title: widget.event.title,
            city: widget.event.venue.city,
            state: widget.event.venue.state,
            dateTime: widget.event.datetimeLocal,
          ),
        );
      },
    );
  }
}
