import 'package:flutter/material.dart';
import 'package:base/domain/repository/authen_repository.dart';
import 'package:base/presentation/base/base_bloc.dart';
import 'package:base/presentation/base/base_event.dart';
import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends BaseBloc<ApplicationEvent, ApplicationState> {
  AuthenticationRepository repository;
  ApplicationBloc({@required this.repository}) : assert(repository != null);

  Stream<ApplicationState> _loadToken() async* {
    final eitherFailureOrTokenAlive = (await repository.getCachedToken());
    yield* eitherFailureOrTokenAlive.fold((failure) async* {
      yield AppLaunchErrorState(message: APP_LAUNCH_ERROR_MESSAGE);
    }, (token) async* {
      final isTokenAlive = token.token.isNotEmpty;
      final launchState = AppLaunchReadyState(isTokenAlive: isTokenAlive);
      yield launchState;
    });
  }

  @override
  ApplicationState get initialState => AppLaunchLoadProfileState();

  @override
  Stream<ApplicationState> mapEventToState(BaseEvent event) async* {
    if (event is AppLaunched) {
      yield* _loadToken();
    } else {
      yield AppLaunchLoadProfileState();
    }
  }

  @override
  void dispose() {}
}
