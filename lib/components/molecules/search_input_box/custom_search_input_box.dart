import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

class CustomSearchInputBox extends StatefulWidget {
  const CustomSearchInputBox({
    super.key,
    this.textInputType = TextInputType.text,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.showSuffixIcon = true,
    this.debounceDuration,
    this.onChanged,
    this.labelText,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
    this.fillColor,
    this.filled,
    this.focusNode,
  });

  final TextInputType textInputType;
  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final bool showSuffixIcon;
  final Duration? debounceDuration;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final Color? fillColor;
  final bool? filled;
  final FocusNode? focusNode;

  @override
  State<CustomSearchInputBox> createState() => _CustomSearchInputBoxState();
}

class _CustomSearchInputBoxState extends State<CustomSearchInputBox> {
  @override
  void initState() {
    super.initState();
    // add listener when suffic icon needs to be displayed
    widget.showSuffixIcon
        ? widget.controller!.addListener(() {
            setState(() {});
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textInputType,
      autofocus: true,
      style: const TextStyle(color: AppColors.backgroundColor),
      cursorColor: AppColors.backgroundColor,
      decoration: InputDecoration(
        hintText: S.current.searchEvents,
        hintStyle: const TextStyle(color: AppColors.offWhiteColor),
        border: InputBorder.none,
        suffixIcon: widget.controller!.text.length > 0
            ? Container(
                transform: Matrix4.translationValues(kSpacingZero, -2, kSpacingZero),
                child: IconButton(
                  onPressed: () {
                    widget.controller!.clear();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: 20,
                  ),
                ),
              )
            : null,
        suffixIconColor: AppColors.backgroundColor,
      ),
      onChanged: widget.debounceDuration != null ? _onChangeWithDebounce : widget.onChanged,
      focusNode: widget.focusNode,
      enabled: true,
      onTapOutside: (_) {
        widget.focusNode!.unfocus();
      },
    );
  }

  void _onChangeWithDebounce(String value) {
    EasyDebounce.debounce(
      S.current.debounceTag,
      widget.debounceDuration!,
      () => widget.onChanged?.call(value),
    );
  }

  @override
  void dispose() {
    widget.showSuffixIcon ? widget.controller!.removeListener(() {}) : null;
    super.dispose();
  }
}
