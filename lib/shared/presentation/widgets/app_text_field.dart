import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  final String hintText;
  final String? labelText;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;

  final bool isObscure;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;

  final List<TextInputFormatter>? inputFormatters;

  final int maxLines;
  final int? minLines;
  final int? maxLength;
   final String? counterText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.isObscure = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength, this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      obscureText: isObscure,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: inputFormatters,
      maxLines: isObscure ? 1 : maxLines,
      minLines: minLines,
      maxLength: maxLength,
      
      decoration: InputDecoration(
        labelText: labelText,
        counterText: counterText??'',
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}