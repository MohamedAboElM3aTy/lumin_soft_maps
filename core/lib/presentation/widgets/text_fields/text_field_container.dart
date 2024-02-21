import 'package:flutter/material.dart';
import 'package:core/app/extensions/context.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      width: context.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: context.seedColor.onTertiary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}