import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/constants/app_strings.dart';
import '../../../../shared/presentation/widgets/app_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return AppButton(
          text: AppStrings.login,
          isLoading: state is AuthLoading,
          onPressed: onPressed,
        );
      },
    );
  }
}