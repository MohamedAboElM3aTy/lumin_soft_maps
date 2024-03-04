import 'package:chat/di/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt chatGetIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
  usesNullSafety: true, // default
)
Future<GetIt> initChatGetIt() async => $initGetIt(chatGetIt);
