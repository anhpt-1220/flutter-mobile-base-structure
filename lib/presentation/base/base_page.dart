import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc.dart';
import 'base_page_mixin.dart';

import 'package:base/app_injector.dart';
export 'package:base/app_injector.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:base/presentation/resources/icons/app_images.dart';
export 'package:base/presentation/styles/styles.dart';

abstract class BasePage<T extends BaseBloc<dynamic, dynamic>>
    extends StatefulWidget {
  BasePage({
    Key key,
    this.bloc,
  }) : super(key: key);

  final BaseBloc bloc;
}

abstract class BasePageState<T extends BaseBloc<BaseEvent, BaseState>,
    P extends BasePage> extends State<P> with BasePageMixin {
  BaseBloc bloc;
  BuildContext subContext;
  @override
  void didChangeDependencies() {
    bloc?.dispatchEvent(PageDidChangeDependenciesEvent(context: context));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    bloc = widget.bloc ?? injector.get<T>();
    bloc?.dispatchEvent(PageInitStateEvent());

    // bloc.messageStream.listen((msg) {
    //   showSnackBarMessage(msg, subContext);
    // });
    super.initState();
  }

  Widget buildChild(BuildContext context, BaseBloc bloc);

  @override
  Widget build(BuildContext context) {
    bloc?.dispatchEvent(PageBuildEvent(context: context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => bloc,
        child: BlocListener<BaseBloc, BaseState>(
            listener: (bloc, state) {},
            child: BlocBuilder(
                bloc: bloc,
                builder: (sub, state) {
                  subContext = sub;
                  return buildChild(subContext, bloc);
                })),
      ),
    );
  }

  @override
  dispose() {
    bloc.dispose();
    super.dispose();
  }
}
