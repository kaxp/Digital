import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/buttons/default_elevated_button.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header1.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header3.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/banner/event_detail_banner.dart';
import 'package:flutter_base_template_1/components/molecules/snackbar/custom_snackbar.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/utils/helpers.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.event});

  final Event event;

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
            onPressed: () => {},
            icon: const Icon(
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
                  title: DateFormatter.formattedFullDateAndTimeWithComma(event.datetimeLocal),
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
  }
}
