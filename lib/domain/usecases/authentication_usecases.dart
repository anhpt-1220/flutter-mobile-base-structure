import 'package:dartz/dartz.dart';
import 'package:base/core/error/failures.dart';
import 'package:base/domain/repository/authen_repository.dart';
import 'package:base/core/error/exceptions.dart';

abstract class AuthenticationUseCases {
  Future<Either<Failure, bool>> login(String username, String password);
}

class AuthenticationUseCaseImpl extends AuthenticationUseCases {
  AuthenticationRepository authenRepo;

  AuthenticationUseCaseImpl(this.authenRepo) : assert(authenRepo != null);

  @override
  Future<Either<Failure, bool>> login(String username, String password) async {
    assert(username.isNotEmpty);
    assert(password.isNotEmpty);
    try {
      await authenRepo.login(username, password);

      return Right(true);
    } on RemoteException catch (ex) {
      return Left(RemoteFailure(msg: ex.errorMessage));
    } on CacheException catch (ex) {
      return Left(CacheFailure(msg: ex.errorMessage));
    } on Exception {
      return Left(UnknownFailure(msg: UNKNOWN_ERROR_MESSAGE));
    }
  }
}
