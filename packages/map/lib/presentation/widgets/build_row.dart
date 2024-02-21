import 'package:core/app/extensions/double.dart';
import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  const BuildRow({
    super.key,
    required this.labelText,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.grey,
        ),
        10.emptyWidth,
        Text(labelText),
      ],
    );
  }
}
