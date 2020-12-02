import 'package:flutter/material.dart';
import 'package:base/presentation/resources/icons/app_images.dart';
import 'package:base/presentation/styles/styles.dart';
import 'package:base/presentation/widgets/app_widgets.dart';

class NumbersKeyboard extends StatelessWidget {
  final double height;
  final Function onPress;
  final String topButtonTitle;
  NumbersKeyboard({this.height, @required this.onPress, this.topButtonTitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildNextButton(),
        ),
        Container(
          padding: EdgeInsets.only(top: 70),
          child: _buildNumbersPad(),
        )
      ],
      fit: StackFit.passthrough,
    );
  }

  _buildNextButton() {
    return Container(
        height: 140,
        child: RoundedButton(
          backgroundColor: AppColors.green58,
          topLeftRadius: 80,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                this.topButtonTitle,
                style: getTextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          onPressed: () {
            this.onPress(KeyboardItem("next", KeyboardItemType.next));
          },
        ));
  }

  _buildNumbersPad() {
    return RoundedContainer(
      height: this.height,
      backgroundColor: AppColors.white,
      topLeftRadius: 70,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton(KeyboardItem("1", KeyboardItemType.number)),
                _buildButton(KeyboardItem("2", KeyboardItemType.number)),
                _buildButton(KeyboardItem("3", KeyboardItemType.number)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton(KeyboardItem("4", KeyboardItemType.number)),
                _buildButton(KeyboardItem("5", KeyboardItemType.number)),
                _buildButton(KeyboardItem("6", KeyboardItemType.number)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton(KeyboardItem("7", KeyboardItemType.number)),
                _buildButton(KeyboardItem("8", KeyboardItemType.number)),
                _buildButton(KeyboardItem("9", KeyboardItemType.number)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: null,
                ),
                _buildButton(KeyboardItem("0", KeyboardItemType.number)),
                _buildButton(KeyboardItem("delete", KeyboardItemType.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildButton(KeyboardItem item) {
    final child = item.type == KeyboardItemType.number
        ? Text(
            item.value,
            style: getTextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.w300),
          )
        : (item.type == KeyboardItemType.delete
            ? Image(
                image: AppImages.iconDelete,
              )
            : Container());
    return FlatButton(
      onPressed: () {
        if (this.onPress != null) this.onPress(item);
      },
      child: child,
    );
  }
}

class KeyboardItem {
  final String value;
  final KeyboardItemType type;
  KeyboardItem(this.value, this.type);
}

enum KeyboardItemType { number, delete, none, next }
