import 'package:dartz/dartz.dart';
import 'package:base/core/error/failures.dart';
import 'package:base/core/network/network_status.dart';
import 'package:base/data/datasource/api/interface_api.dart';
import 'package:base/data/datasource/authen_cache.dart';
import 'package:base/domain/model/token_model.dart';
import 'package:base/domain/repository/authen_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenApi _authenApi;
  AuthenCache _authenCache;
  NetworkStatus _networkStatus;

  AuthenticationRepositoryImpl(
      this._authenApi, this._authenCache, this._networkStatus)
      : assert(_authenApi != null),
        assert(_authenCache != null),
        assert(_networkStatus != null);

  @override
  Future<Either<Failure, TokenModel>> login(
      String username, String password) async {
    assert((username?.isNotEmpty ?? false), 'username is null');
    assert((password?.isNotEmpty ?? false), 'password is null');
    if (await _networkStatus.isConnected) {
      try {
        final token = await _authenApi.login(username, password);
        _authenCache.putToken(token);
        return Right(token);
      } on Exception {
        return Left(RemoteFailure());
      }
    }
    return Left(RemoteFailure());
  }

  @override
  Future<Either<Failure, TokenModel>> getCachedToken() async {
    try {
      var token = await _authenCache.getCachedToken();
      return Right(token);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  logout() async {
    try {
      _authenCache.removeToken();
    } on Exception {
      return Left(CacheFailure());
    }
  }
}
