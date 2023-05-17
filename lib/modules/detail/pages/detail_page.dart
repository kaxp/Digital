import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/buttons/default_elevated_button.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header1.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header3.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/banners/main_event_banner.dart';
import 'package:flutter_base_template_1/components/molecules/snackbar/custom_snackbar.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/detail/bloc/detail_bloc.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.event});

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
    final screenWidth = MediaQuery.of(context).size.width;

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
          body: Padding(
            padding: const EdgeInsets.all(kSpacingMedium),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: MainEventBanner(
                        imageUrl: widget.event.performers[0].image,
                      ),
                    ),
                    const SizedBox(
                      height: kSpacingMedium,
                    ),
                    Header1(
                      title: widget.event.title,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: kSpacingXxSmall,
                    ),
                    Header3(
                      title: '${widget.event.venue.city}, ${widget.event.venue.state}',
                      color: AppColors.lightGreyColor,
                    ),
                    const SizedBox(
                      height: kSpacingXxSmall,
                    ),
                    Header3(
                      title: DateFormatter.formattedFullDateAndTimeWithComma(widget.event.datetimeLocal),
                      color: AppColors.lightGreyColor,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: screenWidth - 32,
                    child: DefaultElevatedButton(
                      title: S.current.bookNow,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          CustomSnackbar(
                            message: S.current.comingSoon,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
