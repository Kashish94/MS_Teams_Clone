import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;

  const ShimmeringLogo({
    Key key,
    @required this.backgroundColor,
    @required this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
        baseColor: backgroundColor,
        highlightColor: foregroundColor,
        child: Image.asset("images/app_logo.png"),
        period: Duration(seconds: 1),
      ),
    );
  }
}
