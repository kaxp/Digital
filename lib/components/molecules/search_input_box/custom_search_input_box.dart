import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

class CustomSearchInputBox extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      autofocus: true,
      style: const TextStyle(color: AppColors.backgroundColor),
      cursorColor: AppColors.backgroundColor,
      decoration:  InputDecoration(
        hintText: S.current.searchEvents,
        hintStyle: const TextStyle(color: AppColors.offWhiteColor),
        border: InputBorder.none,
      ),
      onChanged: debounceDuration != null ? _onChangeWithDebounce : onChanged,
      focusNode: focusNode,
      enabled: true,
    );
  }

  void _onChangeWithDebounce(String value) {
    EasyDebounce.debounce('search', debounceDuration!, () => onChanged?.call(value));
  }
}
