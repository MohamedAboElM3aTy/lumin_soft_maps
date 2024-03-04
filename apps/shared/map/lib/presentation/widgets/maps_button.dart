import 'package:core/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MapsFloatingButton extends StatelessWidget {
  const MapsFloatingButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.whiteColor,
      onPressed: onTap,
      child: Icon(
        icon,
        color: AppColors.blackColor,
      ),
    );
  }
}
