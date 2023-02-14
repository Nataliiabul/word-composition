import 'package:flutter/material.dart';

import 'package:word_composition/style/colors.dart';

class BgContainer extends StatelessWidget {
  const BgContainer({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.7,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          AppColors.mainColor,
          AppColors.firstColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )),
    );
  }
}
