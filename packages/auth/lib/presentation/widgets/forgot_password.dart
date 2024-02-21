import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var authForm = AuthForm.login;
    return authForm == AuthForm.login
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
        : const SizedBox.shrink();
  }
}
