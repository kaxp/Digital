import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';

import '../../../components/atoms/typography/header2.dart';

class DefaultElevatedButton extends StatelessWidget implements PreferredSizeWidget {
  const DefaultElevatedButton({
    required this.title,
    required this.onPressed,
    this.primaryColor,
  });

  final String title;
  final void Function() onPressed;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kMinInteractiveDimension,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor ?? AppColors.redColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Header2(
          title: title,
          fontFamily: AppFonts.ratBold,
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
