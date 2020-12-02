import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import '../../main.dart';

class RemoteNotificationManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //cause firebae 6.0.9 bug https://github.com/FirebaseExtended/flutterfire/issues/277
  // need to hanlde manually push notificaion
  EventChannel _iOSOnMessageChannel;
  EventChannel _iOSOnResumeChannel;

  static const _iOSOnMessageKey = 'com.hl.messenger/onMessage';
  static const _iOSResumeKey = 'com.hl.messenger/onResume';

  config() async {
    _iOSOnMessageChannel = EventChannel(_iOSOnMessageKey);
    _iOSOnResumeChannel = EventChannel(_iOSResumeKey);

    _firebaseMessaging.configure(
        onMessage: onMessageHandler,
        onBackgroundMessage:
            Platform.isIOS ? null : onBackgroundMessageHandlerAndroid,
        onLaunch: onLaunchHandler,
        onResume: onResumeHandler);
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  Future<String> getFcmToken() {
    return _firebaseMessaging.getToken();
  }

  Stream<dynamic> get iOSOnMessage {
    return _iOSOnMessageChannel.receiveBroadcastStream();
  }

  Stream<dynamic> get iOSOnResume {
    return _iOSOnResumeChannel.receiveBroadcastStream();
  }
}
