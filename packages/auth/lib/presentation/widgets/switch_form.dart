import 'package:core/core.dart';
import 'package:flutter/material.dart';

class SwitchForm extends StatefulWidget {
  const SwitchForm({super.key});

  @override
  State<SwitchForm> createState() => _SwitchFormState();
}

class _SwitchFormState extends State<SwitchForm> {
  var _authForm = AuthForm.login;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => setState(
          () {
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
    );
  }
}
