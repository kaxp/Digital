import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';

class Header1 extends StatelessWidget {
  const Header1({
    required this.title,
    this.color,
    this.height,
    this.fontFamily,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 32,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.visible,
  });

  final String title;
  final Color? color;
  final double? height;
  final String? fontFamily;
  final int? maxLines;
  final FontWeight? fontWeight;
  final double? fontSize;

  final TextAlign? textAlign;

  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: color ?? AppColors.blackColor,
            height: height,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? AppFonts.ratBold,
            fontSize: fontSize,
          ),
    );
  }
}
