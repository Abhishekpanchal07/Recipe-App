import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/constants/app_strings.dart';
import 'package:recipe_app/feature/auth/presentation/widgets/login_button.dart';
import 'package:recipe_app/feature/auth/presentation/widgets/password_field.dart';
import 'package:recipe_app/feature/auth/presentation/widgets/username_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  late final FocusNode _usernameFocusNode;
  late final FocusNode _passwordFocusNode;
  

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: const FlutterLogo(size: 80)),

                  const SizedBox(height: 32),

                  Center(
                    child: Text(
                      AppStrings.welcomeBack,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      AppStrings.loginToContinue,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(AppStrings.username),

                  const SizedBox(height: 8),
                  UsernameField(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                  ),

                  const SizedBox(height: 20),

                  PasswordField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (_) => _login(context),
                  ),

                  const SizedBox(height: 32),

                  LoginButton(onPressed: () => _login(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      LoginRequested(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }
}
