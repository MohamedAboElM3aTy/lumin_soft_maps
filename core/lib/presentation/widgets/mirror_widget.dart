import 'dart:math';

import 'package:flutter/material.dart';

class MirrorWidget extends StatelessWidget {
  final Widget child;
  const MirrorWidget({required this.child, this.rotateOn, super.key});
  final Locale? rotateOn;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: Localizations.localeOf(context) == (rotateOn ?? const Locale('ar'))
          ? pi
          : 0,
      child: child,
    );
  }
}