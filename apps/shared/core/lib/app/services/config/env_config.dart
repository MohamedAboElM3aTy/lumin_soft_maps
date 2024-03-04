import 'package:envied/envied.dart';

part 'env_config.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY')
  static const String apiKey = _Env.apiKey;
  @EnviedField(varName: 'GOOGLE_ANDRIOD_API_KEY')
  static const String googleAndriodApiKey = _Env.googleAndriodApiKey;
  @EnviedField(varName: 'GOOGLE_IOS_API_KEY')
  static const String googleIosApiKey = _Env.googleIosApiKey;
}
