import 'package:flutter/material.dart';
import 'package:base/presentation/resources/icons/app_images.dart';
import 'package:base/presentation/styles/styles.dart';
import 'package:base/presentation/widgets/app_widgets.dart';

class SearchTextfield extends StatefulWidget {
  final double height;
  final double radius;
  final Function onPress;
  final String hinText;
  final BorderSide borderSide;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final Color backgoundColor;
  SearchTextfield(
      {this.height = 50,
      this.radius = 0,
      this.onPress,
      this.hinText,
      this.borderSide,
      this.focusNode,
      this.backgoundColor,
      this.onChanged});
  @override
  State<StatefulWidget> createState() {
    return SearchTextfieldState();
  }
}

class SearchTextfieldState extends State<SearchTextfield> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      backgroundColor: this.widget.backgoundColor,
      borderSide: this.widget.borderSide ??
          BorderSide(color: AppColors.green56, width: 0.5),
      allRadius: this.widget.radius,
      height: this.widget.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Image(
              width: 20,
              height: 20,
              image: AppImages.iconSearch,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextField(
                onChanged: this.widget.onChanged,
                controller: this.controller,
                focusNode: this.widget.focusNode,
                decoration: InputDecoration(
                    hintStyle: getHintTextStyle(hintColor: AppColors.blackbc),
                    hintText: this.widget.hinText ?? '',
                    border: InputBorder.none),
                style: getTextStyle(color: AppColors.grey70),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ImageButton(
              30,
              30,
              () {
                this.controller.clear();
                if (this.widget.onChanged != null) {
                  this.widget.onChanged('');
                }
              },
              AppImages.iconClose,
              iconHeight: 15,
              iconWidth: 15,
            ),
          )
        ],
      ),
    );
  }
}
