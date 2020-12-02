import 'package:flutter/material.dart';
import 'package:base/core/utils/array_util.dart';
import 'package:base/presentation/styles/styles.dart';
import 'package:base/presentation/widgets/rounded_container.dart';

class PinInput extends StatelessWidget {
  final Stream<List<String>> stream;
  final double itemHeight;
  final double itemWidth;
  final int spotCount;
  final Color spotColor;
  PinInput(
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
          return Container(
            child: Row(
              children: children,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          );
        },
      ),
    );
  }

  _buildSpotItem(String data) {
    return Container(
      width: data.isEmpty ? 15 : 22,
      height: data.isEmpty ? 15 : 22,
      decoration: BoxDecoration(
          color: data.isEmpty ? Colors.black38 : AppColors.green56,
          borderRadius:
              BorderRadius.all(Radius.circular(data.isEmpty ? 7 : 12))),
    );
  }
}
