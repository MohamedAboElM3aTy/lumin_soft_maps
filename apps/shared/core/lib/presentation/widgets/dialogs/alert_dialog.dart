import 'package:core/app/extensions/context.dart';
import 'package:core/app/extensions/double.dart';
import 'package:core/app/extensions/screen_util.dart';
import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  const ShowAlertDialog({
    super.key,
    required this.streetName,
  });

  final String streetName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 4.0,
      title: Center(
        child: Text(
          context.getText('done'),
        ),
      ),
      content: Text(
        '${context.getText('requestedRide')} $streetName',
        style: context.textTheme.labelSmall?.copyWith(
          fontSize: 14.toFont,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            Text(
              context.getText('pleaseWait'),
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 14.toFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        10.emptyHeight,
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            onPressed: () => context.navigator.pop(),
            child: Text(
              context.getText('ok'),
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontSize: 16.toFont,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
