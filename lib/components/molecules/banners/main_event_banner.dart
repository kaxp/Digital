import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_images.dart';
import 'package:flutter_base_template_1/constants/radius_constants.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';

class MainEventBanner extends StatelessWidget {
  const MainEventBanner({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(kSpacingZero),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kRadiusXSmall),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(kRadiusXSmall),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: double.infinity,
          height: 260,
          fit: BoxFit.cover,
          errorWidget: (context, image, _) => const Image(
            image: AssetImage(
              AppImages.errorPlaceholder,
            ),
            width: double.infinity,
            height: 260,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
