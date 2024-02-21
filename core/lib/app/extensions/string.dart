import 'package:core/app/di/injection_container.dart';
import 'package:logger/logger.dart';

extension StringExtension on String {
  void log({
    Level level = Level.debug,
    required String? message,
  }) {
    getIt<Logger>().log(level, message?.toString());
  }
}