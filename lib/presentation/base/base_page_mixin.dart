import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:base/presentation/resources/icons/app_images.dart';
import 'package:base/presentation/widgets/app_widgets.dart';
import 'package:base/presentation/styles/styles.dart';

export 'package:base/presentation/resources/icons/app_images.dart';
export 'package:base/presentation/styles/text_style.dart';
export 'package:base/presentation/styles/app_colors.dart';
export 'package:base/presentation/resources/localization/app_localization.dart';
export 'package:flutter/material.dart';
export 'package:base/presentation/styles/styles.dart';
export 'package:keyboard_actions/keyboard_actions.dart';
export 'package:base/domain/model/models.dart';
export 'package:base/presentation/utils/device_utils.dart';
export 'package:base/presentation/widgets/app_widgets.dart';
export 'package:base/presentation/scenes/pages.dart';

mixin BasePageMixin {
  Future<void> showSnackBarMessage(String msg, BuildContext context) async {
    final snackBar = SnackBar(
      backgroundColor: AppColors.primaryColor,
      content: Container(
        height: 40,
        color: AppColors.primaryColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(msg,
              style:
                  getTextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
        ),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget buildBackground({EdgeInsets padding}) {
    return Container(
      color: Colors.white,
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Image(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        image: AppImages.mainBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  hideKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<bool> showAlert({
    @required BuildContext context,
    String title,
    @required String message,
    String okActionTitle,
    String cancelTitle,
  }) async {
    List<Widget> actions = [];
    if (cancelTitle?.isNotEmpty ?? false) {
      actions.add(FlatButton(
        child: new Text(cancelTitle,
            style:
                getTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        onPressed: () {
          return Navigator.of(context).pop(false);
        },
      ));
    }

    if (okActionTitle?.isNotEmpty ?? false) {
      actions.add(FlatButton(
        child: new Text(okActionTitle ?? "OK",
            style:
                getTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        onPressed: () {
          return Navigator.of(context).pop(true);
        },
      ));
    }
    return showGeneralDialog<bool>(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: CupertinoAlertDialog(
                  title: new Text(title ?? ''),
                  content: new Text(message),
                  actions: actions),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: 'hheheh',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  buildInputText(
      {bool readOnly = false,
      bool isSecurity = false,
      double height = 40,
      TextInputType keyboardType = TextInputType.text,
      String placeHolder = "",
      FocusNode focusNode,
      TextEditingController controller,
      TextStyle hintStyle,
      TextStyle style,
      Function(String) onChanged,
      InputBorder enabledBorder,
      InputBorder focusedBorder,
      bool autofocus: false,
      int maxLines = 1}) {
    return Container(
      // height: height,
      // color: Colors.green,
      child: Center(
        child: TextField(
          autofocus: autofocus,
          readOnly: readOnly,
          decoration: InputDecoration(
              hintStyle: hintStyle ??
                  getHintTextStyle(hintColor: AppColors.white50, fontSize: 19),
              hintText: placeHolder,
              enabledBorder:
                  enabledBorder ?? underlineBorder(color: Colors.transparent),
              focusedBorder:
                  focusedBorder ?? underlineBorder(color: Colors.transparent)),
          style: style ?? getTextStyle(color: Colors.black, fontSize: 19),
          keyboardType: keyboardType,
          obscureText: isSecurity,
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
        ),
      ),
    );
  }

  pageHeader(
      {@required Stream<String> stream,
      String defaultHeader,
      double height = 100,
      double radius = 10,
      AssetImage backIcon,
      Function onBackPressed,
      Color backgroudColor,
      BoxShadow shadow = defaultBoxShadowWithBlur,
      TextStyle style,
      Widget rightView,
      Widget leftView,
      Gradient gradient,
      double border}) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        final headerTitle = snapshot.data ?? (defaultHeader ?? "");
        return PageHeaderWidget(
            border: border,
            radius: radius,
            gradient: gradient,
            rightView: rightView,
            leftView: leftView,
            textStyle: style ??
                getTextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
            height: height,
            // bottomLeftRadius: bottomLeftRadius,
            title: headerTitle,
            backIcon: backIcon,
            onBackPressed: onBackPressed,
            backgroundColor: backgroudColor,
            shadows: (shadow != null) ? [shadow] : []);
      },
    );
  }

  buildContainerWithBorder(
      {double height = 50,
      double width,
      bool hasBottomBorder = false,
      bool hasTopBorder = false,
      bool hasLeftBorder = false,
      bool hasRightBorder = false,
      BorderSide borderSide =
          const BorderSide(color: AppColors.lightGrey, width: 2),
      Widget child}) {
    Border border = Border(
        right: (hasRightBorder ? borderSide : BorderSide.none),
        bottom: (hasBottomBorder ? borderSide : BorderSide.none),
        left: (hasLeftBorder ? borderSide : BorderSide.none),
        top: (hasTopBorder ? borderSide : BorderSide.none));

    return Container(
      decoration: BoxDecoration(border: border),
      height: height,
      child: child,
      width: width,
    );
  }

  buildHeader(
      {Color secondarayColor = Colors.transparent,
      @required BuildContext context,
      double height = 60,
      double radius = 10,
      Function onBackPressed,
      String pageTitle = "",
      Color backgroundColor,
      Shadow shadow = defaultBoxShadow,
      AssetImage backIcon = AppImages.iconBack,
      TextStyle style,
      Widget rightView,
      Widget leftView,
      Gradient gradient,
      double border}) {
    return Container(
      color: secondarayColor,
      child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: pageHeader(
              border: border,
              radius: radius,
              gradient: gradient,
              rightView: rightView,
              leftView: leftView,
              style: style ??
                  getTextStyle(
                      fontSize: 24,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w400),
              shadow: shadow,
              backgroudColor: backgroundColor,
              height: height,
              stream: null,
              defaultHeader: pageTitle,
              backIcon: backIcon,
              onBackPressed: onBackPressed)),
    );
  }

  TextStyle defaultStyle() => getTextStyle(
      color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w300);
  TextStyle italicStyle(
          {double fontSize = 18, Color color = AppColors.white}) =>
      getTextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic);

  Widget buildItalicText({
    String content = '',
    EdgeInsets padding: const EdgeInsets.only(right: 30),
    TextAlign textAlign: TextAlign.left,
  }) {
    return Padding(
      padding: padding,
      child: Text(
        content,
        style: italicStyle(),
        textAlign: textAlign,
      ),
    );
  }

  buildButton(
      {double width,
      double height,
      double radius,
      TextStyle titleStyle,
      String title,
      Color color,
      VoidCallback onPressed}) {
    return Container(
        color: Colors.transparent,
        height: height,
        width: width,
        child: RoundedTextButton(
            allRadius: radius,
            textStyle: titleStyle,
            backgroundColor: color ?? AppColors.white,
            onPressed: onPressed,
            title: title));
  }

  buildSeparator(
      {EdgeInsets padding = const EdgeInsets.only(left: 20, right: 20),
      double height = 0.5,
      Color color: AppColors.lightGrey}) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        color: color,
      ),
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

  buildSearchTextfield(
      {String hintText,
      EdgeInsetsGeometry padding =
          const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      FocusNode node,
      BorderSide borderSide,
      ValueChanged<String> onChanged}) {
    return Padding(
      padding: padding,
      child: SearchTextfield(
        onChanged: onChanged,
        backgoundColor: AppColors.blackf0,
        borderSide: borderSide ?? BorderSide(color: Colors.transparent),
        height: 35,
        radius: 15,
        hinText: hintText,
        focusNode: node,
      ),
    );
  }

  buildLoading() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  // buildShimmer() {
  //   return Container(
  //     width: double.infinity,
  //     height: double.infinity,
  //     child: Shimmer.fromColors(
  //       baseColor: AppColors.primaryColor,
  //       highlightColor: AppColors.secondaryColor,
  //       child: Center(
  //         child: Text(
  //           'Đang đải dữ liệu...',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: 30.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  buildCircleIndicator() {
    final loadingIndicator = Center(
        child: CircularProgressIndicator(
            backgroundColor: AppColors.white50,
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.secondaryColor)));
    return loadingIndicator;
  }

  Widget buildLoadMoreWidget(int nextPage) {
    return Container(
      height: 50,
      child: Center(
        child: nextPage == 0
            ? Text('Không còn dữ liệu',
                style: getTextStyle(
                  color: AppColors.lightBlack50,
                  fontSize: 15,
                ))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    child: buildCircleIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Đang tải thêm dữ liệu..',
                        style: getTextStyle(
                          color: AppColors.lightBlack50,
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  buildEmptyMessage() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Container(
          height: constraints.maxHeight + 2,
          child: Center(
              child: Text('Danh sách trống',
                  style: getTextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500))),
        ),
      );
    });
  }

  // Future<bool> showLogoutConfirm(BuildContext context) async {
  //   final res = await showAlert(
  //     context: context,
  //     title: AppLocalizations.of(context).confirm,
  //     message: AppLocalizations.of(context).logoutConfirm,
  //     cancelTitle: AppLocalizations.of(context).cancel,
  //     okActionTitle: AppLocalizations.of(context).confirm,
  //   );
  //   return res;
  // }
}
