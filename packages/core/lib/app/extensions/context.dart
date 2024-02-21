import 'package:core/data/enums/app_enums.dart';
import 'package:core/presentation/widgets/snackbar/app_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primaryColor => Theme.of(this).primaryColor;

  ColorScheme get seedColor => Theme.of(this).colorScheme;

  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  String getText(String key) => key.tr();

  NavigatorState get navigator {
    bool isRoot = true;
    return Navigator.of(this, rootNavigator: isRoot);
  }

  Future<T?> showSnackBar<T>({
    required String message,
    SnackBarStates state = SnackBarStates.idle,
    FlashPosition position = FlashPosition.top,
    Duration? duration, required snackBarType,
  }) =>
      this.showFlash<T>(
        duration: duration ?? const Duration(seconds: 3),
        builder: (_, controller) => FlashBar(
          padding: EdgeInsets.zero,
          builder: (_, index) => AppSnackBar(
            message: message,
            state: state,
          ),
          controller: controller,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            // side: BorderSide(),
          ),
          elevation: 0,
          position: FlashPosition.top,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          clipBehavior: Clip.antiAlias,
          behavior: FlashBehavior.floating,
          content: const SizedBox(),
        ),
      );
}
