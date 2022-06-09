import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home_dev/common/smarthome_style.dart';

class TextFieldUnderLine extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focus;
  final String hintText;
  final String? label;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final int maxLine, maxLength;
  final bool isPassword;
  final EdgeInsets padding;
  final Function? onSubmit, onChange;
  final TextStyle? textStyle, hintStyle;
  final List<TextInputFormatter>? filter;

  const TextFieldUnderLine(this.controller, this.focus, this.hintText,
      {Key? key,
      this.textInputAction = TextInputAction.next,
      this.maxLine = 1,
      this.textStyle,
      this.hintStyle,
      this.maxLength = 1000000,
      this.keyboardType = TextInputType.text,
      this.label,
      this.filter,
      this.isPassword = false,
      this.padding = EdgeInsets.zero,
      this.onSubmit,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextField(
      controller: controller,
      focusNode: focus,
      style: textStyle ?? SmartHomeStyle.getDefaultStyle(),
      maxLines: maxLine,
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onSubmitted: (value) {
        if (onSubmit != null) onSubmit!();
      },
      onChanged: (value) {
        if (onChange != null) onChange!();
      },
      inputFormatters: filter ??
          (keyboardType == TextInputType.phone ||
                  keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : []),
      decoration: InputDecoration(
          counterText: '',
          labelText: label,
          isDense: true,
          contentPadding: padding,
          enabledBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: SmartHomeStyle.colorLine, width: 1.0)),
          hintText: hintText,
          hintStyle: hintStyle ?? SmartHomeStyle.getDefaultStyle()));
}
