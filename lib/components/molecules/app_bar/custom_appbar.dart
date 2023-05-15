import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.titleWidget,
    this.isCenter,
    this.actionWidgets,
    this.leadingWidget,
  }) : super(key: key);

  final Widget? titleWidget;
  final bool? isCenter;
  final List<Widget>? actionWidgets;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      leading: leadingWidget,
      elevation: 5,
      backgroundColor: AppColors.primaryColor,
      centerTitle: isCenter,
      title: titleWidget,
      actions: actionWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
