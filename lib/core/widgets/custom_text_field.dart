import 'package:ella/core/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String);

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Validator validator;
  final OnChanged onChanged;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextCapitalization textCapitalization;
  final Color cursorColor;
  final bool enabled;
  final bool obscure;
  final TextInputFormatter? textInputFormatter;
  final TextInputAction textInputAction;
  final String hintText;
  final String? errorText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextStyle? prefixTextStyle;
  final TextStyle? suffixTextStyle;
  final TextStyle? labelTextStyle;
  final String? labelText;
  final String? prefixText;
  final String? suffixText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.onChanged,
    this.textInputType = TextInputType.name,
    required this.focusNode,
    required this.textCapitalization,
    this.cursorColor = ThemeColors.primaryColor,
    this.enabled = true,
    this.obscure = false,
    this.textInputFormatter,
    this.textInputAction = TextInputAction.done,
    this.nextFocusNode,
    required this.hintText,
    this.errorText,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.prefixTextStyle,
    this.suffixTextStyle,
    this.prefixText,
    this.suffixText,
    this.labelTextStyle,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.headline3,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: textInputType,
      focusNode: focusNode,
      textCapitalization: textCapitalization,
      cursorColor: cursorColor,
      enableInteractiveSelection: true,
      obscureText: obscure,
      enabled: enabled,
      textInputAction: textInputAction,
      onEditingComplete: () {
        if(nextFocusNode != null) {
          nextFocusNode?.requestFocus();
        } else {
          focusNode.unfocus();
        }
      },
      onFieldSubmitted: (value) {
        if(nextFocusNode != null) {
          nextFocusNode?.requestFocus();
        } else {
          focusNode.unfocus();
        }
      },
      inputFormatters: textInputFormatter != null
          ? [
              textInputFormatter!,
            ]
          : null,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelTextStyle,
        hintText: hintText,
        hintStyle: Theme.of(context).primaryTextTheme.bodyText2,
        errorText: errorText,
        suffix: suffix,
        suffixIcon: suffixIcon,
        prefix: prefix,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: prefixTextStyle,
        suffixText: suffixText,
        suffixStyle: suffixTextStyle,
      ),
    );
  }
}
