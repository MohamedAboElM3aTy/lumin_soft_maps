import 'package:core/app/constants/app_colors.dart';
import 'package:core/app/services/app_service.dart';
import 'package:core/presentation/widgets/language_switcher/language_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => AppServices.showDefaultModalSheet(
        context: context,
        isDismissible: true,
        isScrollable: false,
        child: const LanguageBottomSheet(),
      ),
      icon: const Icon(PhosphorIcons.globe_hemisphere_east_bold),
      iconSize: 30.0,
      color: AppColors.blackColor,
    );
  }
}
