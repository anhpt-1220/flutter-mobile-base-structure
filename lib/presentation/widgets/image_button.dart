import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final AssetImage icon;
  final BoxFit boxfit;
  final ShapeBorder shape;
  final double iconHeight;
  final double iconWidth;
  final Color iconColor;

  ImageButton(this.width, this.height, this.onPressed, this.icon,
      {this.shape,
      this.iconHeight,
      this.iconWidth,
      this.boxfit = BoxFit.contain,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: shape,
        onPressed: onPressed,
        child: Image(
          color: iconColor,
          image: icon,
          width: iconWidth ?? width,
          height: iconHeight ?? height,
          fit: this.boxfit,
        ),
      ),
    );
  }
}
