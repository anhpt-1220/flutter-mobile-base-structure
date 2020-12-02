import 'package:flutter/material.dart';

class TextImageButton extends StatelessWidget {
  final TextStyle textStyle;
  final String titleBelow;
  final double imageWidth;
  final double imageHeight;
  final AssetImage icon;
  final Color iconColor;
  final VoidCallback onPressed;
  final TextAlign textAlign;
  final Color color;
  final EdgeInsetsGeometry titlePadding;
  final MainAxisAlignment aligment;
  final ShapeBorder shape;

  TextImageButton(
      {Key key,
      this.icon,
      this.imageHeight,
      this.imageWidth,
      this.textStyle,
      this.titleBelow,
      this.onPressed,
      this.textAlign,
      this.titlePadding,
      this.color,
      this.aligment = MainAxisAlignment.center,
      this.shape,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    var listWidget = List<Widget>();
    final imageAvailable = (icon != null);
    if (imageAvailable) {
      listWidget.add(Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Image(
            fit: BoxFit.contain,
            width: imageWidth,
            height: imageHeight,
            image: icon,
            color: iconColor),
      ));
    }

    final titleAvailable = titleBelow?.isNotEmpty ?? false;
    if (titleAvailable) {
      listWidget.add(Padding(
        padding: (titlePadding != null)
            ? titlePadding
            : const EdgeInsets.only(top: 5.0),
        child: Text(
          titleBelow,
          style: textStyle,
          textAlign: this.textAlign,
        ),
      ));
    }

    var button = RaisedButton(
      shape: this.shape,
      elevation: 0.0,
      highlightElevation: 0.0,
      color: this.color ?? Colors.transparent,
      child: Column(
        mainAxisAlignment: this.aligment,
        children: listWidget,
      ),
      onPressed: onPressed,
    );
    return button;
  }
}
