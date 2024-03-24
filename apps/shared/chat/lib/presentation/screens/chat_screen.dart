import 'package:auth/presentation/cubit/auth_cubit.dart';
import 'package:chat/chat.dart';
import 'package:chat/presentation/widgets/chat_messages.dart';
import 'package:chat/presentation/widgets/chat_top_row.dart';
import 'package:chat/presentation/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = chatGetIt<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocProvider.value(
              value: _authCubit,
              child: const ChatTopRow(),
            ),
            const Expanded(
              child: ChatMessages(),
            ),
            const NewMessage(),
          ],
        ),
      ),
    );
  }
}
