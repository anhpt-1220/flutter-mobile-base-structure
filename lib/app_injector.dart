import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:base/domain/repository/authen_repository.dart';
import 'core/network/network_status.dart';
import 'data/datasource/api/authen_api_impl.dart';
import 'data/datasource/api/interface_api.dart';
import 'data/datasource/authen_cache.dart';
import 'data/repository/authen_repository_impl.dart';
import 'data/secure/secure_storage.dart';
import 'domain/usecases/authentication_usecases.dart';
import 'presentation/scenes/user/login/login_bloc.dart';

GetIt injector = GetIt.asNewInstance();

initInjector() {
  injector.registerFactory<AuthenApi>(() => AuthenApiImpl());
  injector.registerFactory<SecureStorage>(() => SecureStorageImpl());
  injector.registerFactory<AuthenticationUseCases>(
      () => AuthenticationUseCaseImpl(injector()));
  injector.registerLazySingleton<AuthenCache>(
      () => AuthenCacheImpl(secureStorage: injector()));
  injector.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(injector(), injector(), injector()));
  injector.registerFactory<LoginBloc>(() => LoginBloc(
        injector(),
      ));

  injector.registerLazySingleton(() => DataConnectionChecker());
  injector.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImpl(injector()));
}
