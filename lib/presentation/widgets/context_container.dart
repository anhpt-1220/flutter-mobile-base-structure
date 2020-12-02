import 'package:flutter/material.dart';

class ContextContainer extends StatefulWidget {
  final Widget child;
  final Function contextProvider;

  ContextContainer({@required this.child, this.contextProvider});

  @override
  State<StatefulWidget> createState() => ContextContainerState();
}

class ContextContainerState extends State<ContextContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contextProvider != null) {
      widget.contextProvider(context);
    }
    return Container(
      child: widget.child,
      // height: 150,
    );
  }
}
