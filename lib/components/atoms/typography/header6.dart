import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';

class Header6 extends StatelessWidget {
  const Header6({
    required this.title,
    this.color,
    this.height,
    this.fontFamily,
    this.textOverflow,
    this.maxLines,
    this.fontSize = 20,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
  });

  final String title;
  final Color? color;
  final double? height;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color ?? AppColors.blackColor,
            height: height,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            fontFamily: fontFamily ?? AppFonts.ratMedium,
            fontSize: fontSize,
          ),
    );
  }
}
