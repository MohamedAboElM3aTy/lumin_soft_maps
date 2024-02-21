import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AuthTextFields extends StatelessWidget {
  const AuthTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    var authForm = AuthForm.login;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          authForm == AuthForm.login
              ? context.getText('login')
              : context.getText('signup'),
          style: context.textTheme.titleLarge?.copyWith(
            fontSize: 22.toFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        20.emptyHeight,
        authForm == AuthForm.register
            ? RoundedTextField(
                controller: firstNameController,
                changed: (firstName) => firstNameController.text = firstName,
                validator: (firstName) {
                  if (firstName!.isEmpty) {
                    return context.getText('enterValidFirstName');
                  }
                  return null;
                },
                hintText: context.getText('firstName'),
              )
            : const SizedBox.shrink(),
        authForm == AuthForm.register
            ? RoundedTextField(
                controller: lastNameController,
                changed: (lastName) => lastNameController.text = lastName,
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
          controller: emailController,
          changed: (email) => emailController.text = email,
          validator: (email) {
            if (!AppValidator.isEmail(email?.trim())) {
              return context.getText('enterValidEmail');
            }
            return null;
          },
          hintText: context.getText('email'),
        ),
        PasswordTextField(
          controller: passwordController,
          onTap: (pass) => passwordController.text = pass,
          validator: (password) {
            if (!AppValidator.isPassword(password)) {
              return context.getText('enterValidPassword');
            }
            return null;
          },
        ),
        20.emptyHeight,
      ],
    );
  }
}
