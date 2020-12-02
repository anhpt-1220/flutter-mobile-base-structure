import 'package:flutter/material.dart';

class BorderText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Border border;
  BorderText({this.text, this.textStyle, this.width, this.height, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      child: Center(
        child: Text(
          this.text,
          style: this.textStyle,
        ),
      ),
      decoration: BoxDecoration(color: Colors.transparent, border: this.border),
    );
  }
}
