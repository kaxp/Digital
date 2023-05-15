import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_images.dart';
import 'package:flutter_base_template_1/constants/radius_constants.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';

import '../../../components/atoms/typography/header2.dart';
import '../../../components/atoms/typography/header4.dart';

class EventListCell extends StatelessWidget {
  const EventListCell({
    Key? key,
    this.imageUrl,
    this.title,
    this.city,
    this.dateAndTime,
  }) : super(key: key);

  final String? imageUrl;
  final String? title;
  final String? city;
  final String? dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(kRadiusXSmall),
          ),
          child: Container(
            color: Colors.black,
            child: CachedNetworkImage(
              height: 54,
              width: 54,
              fit: BoxFit.cover,
              imageUrl: imageUrl.toString(),
              errorWidget: (context, image, _) => const Image(
                height: 54,
                width: 54,
                fit: BoxFit.cover,
                image: AssetImage(
                  AppImages.errorPlaceholder,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kSpacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header2(
                title: title ?? '',
                fontFamily: AppFonts.ratBold,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Header4(
                title: city ?? '',
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                color: AppColors.lightGreyColor,
              ),
              const SizedBox(
                height: kSpacingXxSmall,
              ),
              Header4(
                title: dateAndTime ?? '',
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                color: AppColors.lightGreyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
