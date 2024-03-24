import 'package:auth/presentation/cubit/auth_cubit.dart';
import 'package:auth/presentation/cubit/auth_state.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTopRow extends StatefulWidget {
  const ChatTopRow({super.key});

  @override
  State<ChatTopRow> createState() => ChatTopRowState();
}

class ChatTopRowState extends State<ChatTopRow> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  Future<void> _logOut(BuildContext context) async => await _authCubit.logOut();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LanguageButton(),
        BlocConsumer<AuthCubit, AuthState>(
          bloc: _authCubit,
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (message) {
                context.showSnackBar(
                  message: message,
                  snackBarType: SnackBarStates.error,
                );
              },
              loggedOut: () {
                context.showSnackBar(
                  message: context.getText('logOutSuccess'),
                  snackBarType: SnackBarStates.success,
                );
                context.navigator.popAndPushNamed(AppRoutes.homeRoute);
              },
            );
          },
          builder: (context, state) {
            return IconButton(
              onPressed: () => _logOut(context),
              icon: Icon(
                Icons.logout,
                size: 28.0,
                color: context.primaryColor,
              ),
            );
          },
        ),
      ],
    );
  }
}
