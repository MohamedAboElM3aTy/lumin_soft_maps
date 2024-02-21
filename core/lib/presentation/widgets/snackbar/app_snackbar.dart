import 'package:core/app/constants/app_colors.dart';
import 'package:core/app/extensions/context.dart';
import 'package:core/app/extensions/double.dart';
import 'package:core/app/extensions/screen_util.dart';
import 'package:core/data/enums/app_enums.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({super.key, required this.message, required this.state});

  final String message;
  final SnackBarStates state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _generateSnackBarColor(state),
      ),
      child: Row(
        children: [
          Container(
            width: 32.toWidth,
            height: 32.toWidth,
            padding: const EdgeInsets.all(6),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: _generateSnackBarIconBGColor(state, context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FittedBox(
              child: Icon(
                _generateSnackBarIcons(state),
                color: Colors.white,
              ),
            ),
          ),
          12.toWidth.emptyWidth,
          Expanded(
            child: Text(
              message,
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.black,
                fontSize: 12.toFont,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _generateSnackBarIcons(SnackBarStates states) {
    switch (states) {
      case SnackBarStates.idle:
        return Icons.info_rounded;
      case SnackBarStates.success:
        return Icons.check_circle;
      case SnackBarStates.error:
        return Icons.cancel;
    }
  }

  Color _generateSnackBarColor(SnackBarStates states) {
    switch (states) {
      case SnackBarStates.idle:
        return AppColors.lightAccentColor;
      case SnackBarStates.success:
        return AppColors.lightSuccessColor;
      case SnackBarStates.error:
        return AppColors.lightError;
    }
  }

  Color _generateSnackBarIconBGColor(
      SnackBarStates states, BuildContext context) {
    switch (states) {
      case SnackBarStates.idle:
        return AppColors.accentColor;
      case SnackBarStates.success:
        return context.primaryColor;
      case SnackBarStates.error:
        return AppColors.error;
    }
  }
}
