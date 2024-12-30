import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
 class Env {

  @EnviedField(varName: 'CLIENT_ID', obfuscate: true)
  static final String client_ID = _Env.client_ID;

  @EnviedField(varName: 'CLIENT_SECRET', obfuscate: true)
  static final String client_Secret = _Env.client_Secret;
}