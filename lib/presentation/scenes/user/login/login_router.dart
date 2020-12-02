import 'package:flutter/material.dart';
import 'package:base/presentation/base/base_router.dart';

class LoginRouter with BaseRouter {
  onNavigate({@required BuildContext context}) {
    // final page = PinPage(
    //   bloc: applicationBloc(context).container.get<AuthenByPinBloc>(),
    //   title: AppLocalizations.of(context).inputPin,
    // );
    // pageNavigator(context)
    //     .materialPush(context: context, page: page, tag: AppState.pinAuthen);
  }
}
