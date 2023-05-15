import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_fonts.dart';

class DefaultTextButton extends StatelessWidget implements PreferredSizeWidget {
  const DefaultTextButton({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: AppFonts.ratBold,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
