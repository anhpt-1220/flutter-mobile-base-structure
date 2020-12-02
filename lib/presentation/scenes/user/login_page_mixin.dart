import 'package:flutter/material.dart';
import 'package:base/presentation/base/base_page_mixin.dart';
import 'package:base/presentation/widgets/app_widgets.dart';

class LoginPageMixin {
  buildInputRow(
      {bool isSecurity = false,
      TextInputType type = TextInputType.text,
      AssetImage icon,
      String tintText,
      FocusNode node,
      Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: RoundedContainer(
          padding: const EdgeInsets.all(10.0),
          allRadius: 27,
          borderSide: BorderSide(
            color: Colors.white,
          ),
          height: 55,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      color: Colors.white,
                      image: icon,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain),
                ),
                Expanded(
                    child: buildInputText(
                        isSecurity: isSecurity,
                        keyboardType: type,
                        onChanged: onChanged,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusNode: node,
                        placeHolder: tintText,
                        style: getTextStyle(
                            fontSize: 20, color: AppColors.white))),
              ])),
    );
  }

  buildInputText({
    bool isSecurity = false,
    double height = 50,
    TextInputType keyboardType = TextInputType.text,
    String placeHolder = "",
    FocusNode focusNode,
    TextEditingController controller,
    TextStyle hintStyle,
    TextStyle style,
    Function(String) onChanged,
    InputBorder enabledBorder,
    InputBorder focusedBorder,
  }) {
    return Container(
      height: height,
      child: TextField(
        decoration: InputDecoration(
            hintStyle: hintStyle ??
                getHintTextStyle(hintColor: AppColors.white50, fontSize: 19),
            hintText: placeHolder,
            enabledBorder:
                enabledBorder ?? underlineBorder(color: AppColors.lightBlack50),
            focusedBorder:
                focusedBorder ?? underlineBorder(color: AppColors.green56)),
        style: style ?? getTextStyle(color: Colors.black, fontSize: 19),
        keyboardType: keyboardType,
        obscureText: isSecurity,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
