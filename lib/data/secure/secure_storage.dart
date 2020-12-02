import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<String> getStoredToken();
  removeToken();
  updateToken({@required String token});
}

const TOKEN_KEY = "TOKEN_KEY";

class SecureStorageImpl extends SecureStorage {
  final storage = new FlutterSecureStorage();

  @override
  Future<String> getStoredToken() async {
    String token = await storage.read(key: TOKEN_KEY);
    return token;
  }

  @override
  removeToken() async {
    await storage.delete(key: TOKEN_KEY);
  }

  @override
  updateToken({@required String token}) async {
    await storage.write(key: TOKEN_KEY, value: token);
  }
}
