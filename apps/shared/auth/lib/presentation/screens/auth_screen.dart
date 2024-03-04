import 'package:auth/di/injection_container.dart';
import 'package:auth/presentation/cubit/auth_cubit.dart';
import 'package:auth/presentation/cubit/auth_state.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.isClient});

  final bool isClient;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  var _authForm = AuthForm.login;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _authCubit = locater<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [LanguageButton()]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 30.0,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _authForm == AuthForm.login
                        ? context.getText('login')
                        : context.getText('signup'),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 22.toFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  20.emptyHeight,
                  _authForm == AuthForm.register
                      ? RoundedTextField(
                          controller: _firstNameController,
                          focusNode: _firstNameFocusNode,
                          autoFocus:
                              _authForm == AuthForm.register ? true : false,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_lastNameFocusNode),
                          changed: (firstName) =>
                              _firstNameController.text = firstName,
                          validator: (firstName) {
                            if (firstName!.isEmpty) {
                              return context.getText('enterValidFirstName');
                            }
                            return null;
                          },
                          hintText: context.getText('firstName'),
                        )
                      : const SizedBox.shrink(),
                  _authForm == AuthForm.register
                      ? RoundedTextField(
                          controller: _lastNameController,
                          focusNode: _lastNameFocusNode,
                          autoFocus: false,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          changed: (lastName) =>
                              _lastNameController.text = lastName,
                          validator: (lastName) {
                            if (lastName!.isEmpty) {
                              return context.getText('enterValidLastName');
                            }
                            return null;
                          },
                          hintText: context.getText('lastName'),
                        )
                      : const SizedBox.shrink(),
                  RoundedTextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    autoFocus: _authForm == AuthForm.login ? true : false,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    changed: (email) => _emailController.text = email,
                    validator: (email) {
                      if (!AppValidator.isEmail(email?.trim())) {
                        return context.getText('enterValidEmail');
                      }
                      return null;
                    },
                    hintText: context.getText('email'),
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    onTap: (pass) => _passwordController.text = pass,
                    validator: (password) {
                      if (!AppValidator.isPassword(password)) {
                        return _authForm == AuthForm.register
                            ? context.getText('enterValidPassword')
                            : context.getText('wrongPassword');
                      }
                      return null;
                    },
                  ),
                  15.emptyHeight,
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '•  Password Must have 1 Capital letter',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 12.toFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        3.emptyHeight,
                        Text(
                          '•  Password Must have 1 Small letter',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 12.toFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        3.emptyHeight,
                        Text(
                          '•  Password Must have 1 special Character',
                          style: context.textTheme.labelMedium?.copyWith(
                            fontSize: 12.toFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.emptyHeight,
                  _authForm == AuthForm.login
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            context.getText('forgotPassword'),
                            style: context.textTheme.labelMedium?.copyWith(
                              fontSize: 16.toFont,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  50.emptyHeight,
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: _authCubit,
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () => null,
                        authenticated: (user) {
                          context.showSnackBar(
                            message: context.getText('loginSuccess'),
                            snackBarType: SnackBarStates.success,
                          );
                          widget.isClient
                              ? context.navigator.pushReplacementNamed(
                                  AppRoutes.mapClientRoute)
                              : context.navigator.pushReplacementNamed(
                                  AppRoutes.mapDriverRoute);
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
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            _authForm == AuthForm.login
                                ? await _authCubit.signIn(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  )
                                : await _authCubit.signUp(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
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
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => setState(
                        () {
                          _formKey.currentState!.reset();
                          if (_authForm == AuthForm.login) {
                            _authForm = AuthForm.register;
                          } else {
                            _authForm = AuthForm.login;
                          }
                        },
                      ),
                      child: Text(
                        _authForm == AuthForm.login
                            ? context.getText('dontHaveAccount')
                            : context.getText('haveAnAccount'),
                        style: context.textTheme.labelMedium?.copyWith(
                          fontSize: 16.toFont,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
