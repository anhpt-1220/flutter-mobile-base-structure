import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base/presentation/app/application_bloc.dart';
import 'package:base/presentation/app/application_event.dart';
import 'package:base/presentation/app/application_state.dart';
import 'package:base/presentation/resources/localization/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:base/presentation/scenes/navigator/observer_route.dart';

import 'domain/model/push_payload_model.dart';
import 'domain/repository/authen_repository.dart';
import 'presentation/base/base_bloc.dart';
import 'presentation/scenes/user/login/login_page.dart';
import 'presentation/styles/app_colors.dart';
import 'presentation/styles/text_style.dart';
import './app_injector.dart';

ApplicationBloc _appBloc;

void main() async {
  await initInjector();
  _appBloc = ApplicationBloc(repository: injector<AuthenticationRepository>());
  runApp(BlocProvider<ApplicationBloc>(
      create: (BuildContext context) => _appBloc, child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _appBloc.dispatchEvent(AppLaunched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.deepOrange,
          ),
      home: BlocBuilder<ApplicationBloc, BaseState>(builder: (context, state) {
        if (state is AppLaunchReadyState) {
          return state.isTokenAlive ? LoginPage() : LoginPage();
        }
        return _buidLoadingProfileScene();
      }),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLanguages(),
      navigatorObservers: [routeObserver],
    );
  }

  _buidLoadingProfileScene() {
    return Scaffold(
      body: Container(
          child: Center(
              child: Text("Đang tải dữ liệu...",
                  style: getTextStyle(
                      fontSize: 22,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold))),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.secondaryColor, AppColors.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          )),
    );
  }
}

Future<dynamic> onBackgroundMessageHandlerAndroid(
    Map<String, dynamic> message) async {
  print('_onBackgroundMessageHandler $message');
  // final payload = PushPayloadModel.fromJson(message);
}

Future<dynamic> onMessageHandler(Map<String, dynamic> message) async {
  print('_onMessageHandler $message  ');
  // final payload = PushPayloadModel.fromJson(message);
}

Future<dynamic> onLaunchHandler(Map<String, dynamic> message) async {
  print('_onLaunchHandler $message');
  final payload = PushPayloadModel.fromJson(message);
  // _appBloc.dispatchEvent((WakeUpByPushEvent(payload: payload)));
  print('weakup by push ${payload.messageId}');
}

Future<dynamic> onResumeHandler(Map<String, dynamic> message) async {
  // if (_appState != AppLifecycleState.resumed) return;
  print('_onResumeHandler =================>>>>> $message ');
  final payload = PushPayloadModel.fromJson(message);
  print('wakeup by push ==========================>>>>  ${payload.messageId}');
  // _appBloc.dispatchEvent((WakeUpByPushEvent(payload: payload)));
}
