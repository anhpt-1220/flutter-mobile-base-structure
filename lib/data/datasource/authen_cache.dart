import 'package:flutter/foundation.dart';
import 'package:base/data/secure/secure_storage.dart';
import 'package:base/domain/model/token_model.dart';

abstract class AuthenCache {
  Future<TokenModel> getCachedToken();
  void putToken(TokenModel token);
  void removeToken();
}

class AuthenCacheImpl extends AuthenCache {
  TokenModel _token;
  SecureStorage _secureStorage;
  AuthenCacheImpl({@required SecureStorage secureStorage})
      : assert(secureStorage != null),
        _secureStorage = secureStorage;

  @override
  Future<TokenModel> getCachedToken() async {
    if (_token == null) {
      final saveTokenString = await _secureStorage.getStoredToken() ?? '';
      _token = TokenModel(token: saveTokenString);
    }
    return _token;
  }

  @override
  void putToken(TokenModel token) {
    _secureStorage.updateToken(token: token.token);
    this._token = token;
  }

  @override
  removeToken() async {
    _token = null;
    await _secureStorage.removeToken();
  }
}
