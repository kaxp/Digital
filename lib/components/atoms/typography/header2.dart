import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';

class Header2 extends StatelessWidget {
  const Header2({
    required this.title,
    this.color,
    this.height,
    this.fontFamily,
    this.maxLines,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 16,
    this.textAlign = TextAlign.start,
    this.textOverflow,
  });

  final String title;
  final Color? color;
  final double? height;
  final String? fontFamily;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: color ?? AppColors.blackColor,
            height: height,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? AppFonts.ratMedium,
            fontSize: fontSize,
          ),
    );
  }
}
