import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:word_composition/style/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
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
            ),
            Positioned(
              left: (width-(width*0.8))/2,
              bottom: (height-(height*0.7))/3,
              child: Container(
                width: width*0.8,
                height: height*0.45,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
