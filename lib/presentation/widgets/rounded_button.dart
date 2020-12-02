import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final double allRadius;
  final Color backgroundColor;
  final Widget child;
  final double elevation;
  final double highlightElevation;
  final BorderSide boderSide;

  RoundedButton(
      {@required this.child,
      @required this.onPressed,
      this.backgroundColor = Colors.grey,
      this.topLeftRadius = 0,
      this.bottomLeftRadius = 0,
      this.bottomRightRadius = 0,
      this.topRightRadius = 0,
      this.allRadius,
      this.elevation = 2,
      this.highlightElevation = 2,
      this.boderSide});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: allRadius != null
            ? BorderRadius.all(Radius.circular(allRadius))
            : BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius),
                topRight: Radius.circular(topRightRadius),
                bottomLeft: Radius.circular(bottomLeftRadius),
                bottomRight: Radius.circular(bottomRightRadius)),
        side: boderSide ?? BorderSide.none,
      ),
      color: this.backgroundColor,
      onPressed: onPressed ?? () {},
      child: this.child,
      elevation: this.elevation,
      highlightElevation: this.highlightElevation,
    );
  }
}
