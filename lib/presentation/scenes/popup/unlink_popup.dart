import 'package:flutter/material.dart';
import 'package:base/presentation/base/base_page_mixin.dart';

class UnlinkPopup extends StatefulWidget {
  @override
  UnlinkPopupState createState() => UnlinkPopupState();
}

class UnlinkPopupState extends State<UnlinkPopup> with BasePageMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: RoundedContainer(
            height: 320,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  width: 50,
                  height: 50,
                  image: null,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'POP'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: RoundedButton(
                    backgroundColor: Colors.white,
                    allRadius: 25,
                    child: Text(
                      'Đồng Ý',
                      style: getTextStyle(
                          fontSize: 17,
                          color: AppColors.green56,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 250,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: RoundedButton(
                    backgroundColor: Colors.white,
                    allRadius: 25,
                    child: Text(
                      'Huỷ',
                      style: getTextStyle(
                          fontSize: 17,
                          color: AppColors.grey70,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            topRightRadius: 60,
            bottomLeftRadius: 60,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [AppColors.green56, AppColors.green58],
            )),
      ),
    );
  }
}
