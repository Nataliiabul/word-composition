import 'package:flutter/material.dart';
import 'package:word_composition/screens/game_screen.dart';

import 'package:word_composition/widgets/bg_container.dart';
import 'package:word_composition/widgets/card_with_info.dart';

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

    void toGame () {
      Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
    }
    return Scaffold(
      // main screen container
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            // bg container with color
            BgContainer(width: width, height: height),

            // card with information
            CardWithInfo(width: width, height: height, function: toGame),

            // circle logo
            Positioned(
              top: height*0.15,
              left: (width-200)/2,
              child: CircleAvatar(
                backgroundColor: AppColors.firstColor,
                radius: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}