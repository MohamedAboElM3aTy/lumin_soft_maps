import 'package:auth/presentation/cubit/auth_cubit.dart';
import 'package:auth/presentation/cubit/auth_state.dart';
import 'package:auth/presentation/widgets/auth_text_fields.dart';
import 'package:auth/presentation/widgets/forgot_password.dart';
import 'package:auth/presentation/widgets/switch_form.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final GlobalKey<FormState> _formKey;
  late final AuthCubit _authCubit;
  final _authForm = AuthForm.login;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _authCubit = getIt<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LanguageButton()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 30.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthTextFields(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                ),
                const ForgotPassword(),
                20.emptyHeight,
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: _authCubit,
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () => null,
                      authenticated: (user) {
                        context.navigator
                            .pushReplacementNamed(AppRoutes.mapRoute);
                      },
                      error: (message) {
                        context.showSnackBar(
                          message: message,
                          snackBarType: SnackBarStates.error,
                        );
                      },
                    );
                  },
                  builder: (context, state) {
                    return AppButton(
                      width: context.screenWidth * 0.9,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 0,
                      ),
                      isLoading: state.maybeWhen(
                        orElse: () => false,
                        loading: () => true,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _authForm == AuthForm.login
                              ? await _authCubit.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                )
                              : await _authCubit.signUp(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                        }
                      },
                      label: _authForm == AuthForm.login
                          ? context.getText('login')
                          : context.getText('signup'),
                    );
                  },
                ),
                20.emptyHeight,
                const SwitchForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
