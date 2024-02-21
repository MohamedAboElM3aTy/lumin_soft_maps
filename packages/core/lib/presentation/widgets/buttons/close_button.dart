import 'package:core/app/constants/app_colors.dart';
import 'package:core/app/extensions/context.dart';
import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigator.pop(),
      child: const CircleAvatar(
        radius: 15,
        backgroundColor: AppColors.accentColor,
        child: Icon(Icons.close, color: Colors.white),
      ),
    );
  }
}
