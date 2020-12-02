import 'package:base/data/entity/entities.dart';

abstract class AuthenApi {
  Future<TokenEntity> login(String username, String password);
}
