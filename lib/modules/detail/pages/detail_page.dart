import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header1.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header3.dart';
import 'package:flutter_base_template_1/components/molecules/app_bar/custom_appbar.dart';
import 'package:flutter_base_template_1/components/molecules/banner/event_detail_banner.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

class DetailPage extends StatelessWidget {
  Widget build(BuildContext context) {
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
          children: const [
            Center(
              child: EventDetailBanner(
                imageUrl:
                    'https://seatgeek.com/images/performers-landscape/laugh-factory-las-vegas-8d0faf/794871/huge.jpg',
              ),
            ),
            SizedBox(
              height: kSpacingMedium,
            ),
            Header1(
              title: 'This is movie title',
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: kSpacingXxSmall,
            ),
            Header3(
              title: 'This is the date and time',
              color: AppColors.lightGreyColor,
            ),
            SizedBox(
              height: kSpacingXxSmall,
            ),
            Header3(
              title: 'This is the city name',
              color: AppColors.lightGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
