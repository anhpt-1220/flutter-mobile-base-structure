import 'dart:async';
import 'package:base/domain/usecases/authentication_usecases.dart';
import 'package:base/presentation/base/base_bloc.dart';
import 'package:base/presentation/biometric/biometric.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  AuthenticationUseCases authenUseCases;

  final _biometricSupport = PublishSubject<BiometricType>();
  Stream<BiometricType> get biometricStream => _biometricSupport.stream;

  final _appInReview = PublishSubject<bool>();
  Stream<bool> get appInReviewStream => _appInReview.stream;

  final _fullName = PublishSubject<String>();
  Stream<String> get fullNameStream => _fullName.stream;

  final _username = ReplaySubject<String>();
  final _password = ReplaySubject<String>();

// retrieve data from stream
  Stream<String> get usernameStream =>
      _username.stream.transform(validateUsername);
  Stream<String> get passwordStream =>
      _password.stream.transform(validatePassword);

  Stream<bool> get submitValid => Rx.combineLatest2<String, String, bool>(
      usernameStream,
      passwordStream,
      (usernameValid, passwordValid) =>
          usernameValid.isNotEmpty && passwordValid.isNotEmpty);

  // add data to stream
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;

  //constructor
  LoginBloc(this.authenUseCases) : assert(authenUseCases != null);

  _getSupportBiometric() async {
    final biometricType = await Biometric().getAvailableBiometric();
    _biometricSupport.add(biometricType);
  }

  Stream<BaseState> _login(String username, String password) async* {
    final eitherFailureOrSuccess =
        await authenUseCases.login(username, password);
    yield* eitherFailureOrSuccess.fold((failure) async* {
      yield LoginFailureState();
    }, (token) async* {
      yield LoginSuccessState();
    });
  }

  @override
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is PageBuildEvent) {
      // await _fetchSystemConfig();
    }

    if (event is OnRequestLogInEvent) {
      final username = _username.values.last;
      final password = _password.values.last;
      yield* _login(username, password);
    }
    if (event is PageInitStateEvent) {
      await _getSupportBiometric();
    }
  }

  @override
  dispose() {
    _username.close();
    _password.close();
  }
}
