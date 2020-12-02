import 'package:flutter/material.dart';
import 'package:base/core/utils/array_util.dart';
import 'package:base/presentation/styles/styles.dart';
import 'package:base/presentation/widgets/rounded_container.dart';

class OtpInput extends StatelessWidget {
  final Stream<List<String>> stream;
  final double itemHeight;
  final double itemWidth;
  final int spotCount;
  final Color spotColor;
  OtpInput(
      {@required this.stream,
      this.itemHeight = 60,
      this.itemWidth = 60,
      this.spotCount = 4,
      this.spotColor = AppColors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: StreamBuilder<List<String>>(
        stream: this.stream,
        builder: (buildContext, AsyncSnapshot<List<String>> snapshot) {
          List<Widget> children = List<Widget>();
          for (var index = 0; index < spotCount; index++) {
            final data = getOrNull(snapshot.data, index) ?? "";
            children.add(_buildSpotItem(data));
          }
          return Row(
            children: children,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          );
        },
      ),
    );
  }

  _buildSpotItem(String data) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: itemHeight, maxWidth: itemWidth),
      child: RoundedContainer(
        child: Center(
          child: Text(
            data,
            style: getTextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ),
        backgroundColor: spotColor,
        topLeftRadius: 15,
        bottomRightRadius: 15,
        bottomLeftRadius: 15,
        topRightRadius: 15,
        height: 60,
      ),
    );
  }
}
