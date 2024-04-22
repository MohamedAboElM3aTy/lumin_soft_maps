import 'package:core/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MapsFloatingButton extends StatelessWidget {
  const MapsFloatingButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.heroTag,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      backgroundColor: AppColors.whiteColor,
      onPressed: onTap,
      child: Icon(
        icon,
        color: AppColors.blackColor,
      ),
    );
  }
}
