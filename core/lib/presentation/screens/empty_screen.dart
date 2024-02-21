import 'package:core/app/constants/app_assets.dart';
import 'package:core/app/extensions/context.dart';
import 'package:core/app/extensions/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        child: SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            elevation: 0,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.emptyImage),
                Text(
                  message ?? context.getText('somethingWentWrong'),
                  style: context.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5.toHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}