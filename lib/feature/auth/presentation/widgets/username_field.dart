import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  const UsernameField({
    super.key,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      hintText: AppStrings.enterUsername,
      labelText: AppStrings.username,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      maxLength: 30,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-Z]'),
        ),
      ],
      validator: Validators.username,
    );
  }
}