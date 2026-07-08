import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> _isVisible = ValueNotifier(false);

  @override
  void dispose() {
    _isVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isVisible,
      builder: (_, visible, _) {
        return AppTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          hintText: AppStrings.enterPassword,
          labelText: AppStrings.password,
          isObscure: !visible,
          textInputAction: TextInputAction.done,
          maxLength: 32,
          validator: Validators.password,
          onFieldSubmitted: widget.onFieldSubmitted,
          suffixIcon: IconButton(
            onPressed: () {
              _isVisible.value = !visible;
            },
            icon: Icon(
              visible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        );
      },
    );
  }
}