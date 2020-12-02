import 'package:base/presentation/base/base_event.dart';

abstract class ApplicationEvent extends BaseEvent {}

class LoadingEvent extends ApplicationEvent {}

class AppLaunched extends ApplicationEvent {}
