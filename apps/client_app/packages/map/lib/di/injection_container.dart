import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:map/di/injection_container.config.dart';

GetIt mapsGetIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: false, // default
  asExtension: false, // default
  usesNullSafety: true, // default
)

Future<GetIt> initMapsGetIt() async => $initGetIt(mapsGetIt);
