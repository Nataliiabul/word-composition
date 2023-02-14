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
      // main screen container
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            // bg container with color
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

            // card with information
            Positioned(
              left: (width - (width * 0.8)) / 2,
              bottom: (height - (height * 0.7)) / 3,
              child: Container(
                padding: const EdgeInsets.all(15),
                width: width * 0.8,
                height: height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.mainColor,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "WORD COMPOSITION",
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'У вас будет 5 минут, чтобы отгадать все слова. Для начала игры нажмите кнопку "старт"',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.mainColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "СТАРТ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          shape: StadiumBorder(),
                          shadowColor: AppColors.mainColor),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height*0.12,
              left: (width-200)/2,
              child: CircleAvatar(
                backgroundColor: AppColors.mainColor,
                radius: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
