import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/buttons/default_elevated_button.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header1.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header3.dart';
import 'package:flutter_base_template_1/components/molecules/banners/main_event_banner.dart';
import 'package:flutter_base_template_1/components/molecules/snackbar/custom_snackbar.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/utils/helpers.dart';

class DetailMainBodyView extends StatelessWidget {
  const DetailMainBodyView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.city,
    required this.state,
    required this.dateTime,
  });

  final String imageUrl;
  final String title;
  final String? city;
  final String? state;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(kSpacingMedium),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: MainEventBanner(
                  imageUrl:imageUrl ,
                ),
              ),
              const SizedBox(
                height: kSpacingMedium,
              ),
              Header1(
                title: title,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Header3(
                title: '$city, $state',
                color: AppColors.lightGreyColor,
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Header3(
                title: DateFormatter.formattedFullDateAndTimeWithComma(dateTime),
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
    );
  }
}
