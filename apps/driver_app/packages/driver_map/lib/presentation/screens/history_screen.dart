import 'package:core/core.dart';
import 'package:driver_map/presentation/widgets/history_rides.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.getText('historyRides'),
                    style: context.textTheme.labelLarge?.copyWith(
                      fontSize: 20.toFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: LanguageButton(),
                  ),
                ],
              ),
              const HistoryRides(),
            ],
          ),
        ),
      ),
    );
  }
}
