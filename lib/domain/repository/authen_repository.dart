import 'package:dartz/dartz.dart';
import 'package:base/core/error/failures.dart';

import '../model/token_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, TokenModel>> login(String username, String password);
  logout();
  Future<Either<Failure, TokenModel>> getCachedToken();
}
