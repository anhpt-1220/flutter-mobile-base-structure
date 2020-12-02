import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:base/presentation/widgets/context_container.dart';

class FormKeyboardActionsWithContext extends StatelessWidget {
  final Widget child;
  final List<FocusNode> focusNodes;
  final bool autoScroll;

  FormKeyboardActionsWithContext(
      {@required this.child, this.focusNodes, this.autoScroll = true});

  @override
  Widget build(BuildContext context) {
    return FormKeyboardActions(
      autoScroll: this.autoScroll,
      child: ContextContainer(
          child: child,
          contextProvider: (subContext) {
            FormKeyboardActions.setKeyboardActions(
                subContext, buildKeyboardConfig(nodes: focusNodes ?? []));
          }),
    );
  }

  KeyboardActionsConfig buildKeyboardConfig({List<FocusNode> nodes}) {
    final actions = nodes.map((node) {
      return KeyboardAction(
        focusNode: node,
      );
    }).toList();
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        nextFocus: true,
        actions: actions);
  }
}
