import 'package:flutter/material.dart';
import 'package:base/presentation/styles/styles.dart';
import 'package:base/presentation/widgets/image_button.dart';
import 'package:base/presentation/widgets/rounded_container.dart';

class PageHeaderWidget extends StatelessWidget {
  final double height;
  final String title;
  final double radius;
  final Color backgroundColor;
  final TextStyle textStyle;
  final AssetImage backIcon;
  final Function onBackPressed;
  final List<BoxShadow> shadows;
  final Widget rightView;
  final Widget leftView;
  final Gradient gradient;
  final double border;

  PageHeaderWidget(
      {@required this.height,
      this.title = "",
      this.radius = 0,
      this.textStyle,
      this.backgroundColor,
      this.backIcon,
      this.onBackPressed,
      this.shadows,
      this.rightView,
      this.leftView,
      this.gradient,
      this.border});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    final title = Center(
      child: Text(this.title,
          style: this.textStyle ??
              getTextStyle(
                  color: AppColors.lightBlack50,
                  fontSize: 28,
                  fontWeight: FontWeight.w400)),
    );
    children.add(title);
    if (this.leftView != null) {
      children
          .add(Align(alignment: Alignment.centerLeft, child: this.leftView));
    }
    if (this.backIcon != null && this.leftView == null) {
      final backButton = Positioned(
        top: 0,
        left: 10,
        child: ImageButton(30, 30, () {
          if (onBackPressed != null) onBackPressed();
        }, backIcon, iconWidth: 12, iconHeight: 18),
      );
      children.add(backButton);
    }
    if (this.rightView != null) {
      children
          .add(Align(alignment: Alignment.centerRight, child: this.rightView));
    }

    return RoundedContainer(
      // borderSide: border != null
      //     ? BorderSide(width: border, color: AppColors.lightGrey16)
      //     : null,
      gradient: gradient,
      shadows: this.shadows,
      backgroundColor: backgroundColor ?? AppColors.white,
      height: this.height,
      allRadius: this.radius,
      child: Stack(
        children: children,
      ),
    );
  }
}
