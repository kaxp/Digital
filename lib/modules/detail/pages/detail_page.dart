import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header1.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header3.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/banner/event_detail_banner.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.event});

  final Event event;

  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd – kk:mm');
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Text(
          S.current.detailPage,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: AppFonts.ratMedium,
          ),
        ),
        isCenter: true,
        actionWidgets: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.favorite_border,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kSpacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: EventDetailBanner(
                imageUrl: event.performers[0].image,
              ),
            ),
            const SizedBox(
              height: kSpacingMedium,
            ),
            Header1(
              title: event.title,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(
              height: kSpacingXxSmall,
            ),
            Header3(
              title: '${event.venue.city}, ${event.venue.state}',
              color: AppColors.lightGreyColor,
            ),
            const SizedBox(
              height: kSpacingXxSmall,
            ),
            Header3(
              title: formatter.format(
                event.datetimeLocal,
              ),
              color: AppColors.lightGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
