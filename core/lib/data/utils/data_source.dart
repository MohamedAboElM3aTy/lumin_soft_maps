import 'package:core/data/models/app_exception.dart';
import 'package:logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';

Future<T> resolveOrThrow<T>(
  Future<T> Function() target, {
  String? context,
}) async {
  final logger = Logger();
  try {
    return await target();
  } on Exception catch (e, s) {
    logger.e('DataSourceError:\n $e', error: e, stackTrace: s);

    throw GenericApplicationException(message: ('somethingWentWrong').tr());
  } catch (e, s) {
    logger.e('DataSourceError:\n $e', error: e, stackTrace: s);

    throw GenericApplicationException(
      message: ('somethingWentWrong').tr(),
    );
  }
}