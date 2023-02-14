import 'package:flutter/material.dart';

import 'package:word_composition/style/colors.dart';

class CardWithInfo extends StatelessWidget {
  const CardWithInfo({
    Key? key,
    required this.width,
    required this.height,
    required this.function,
  }) : super(key: key);

  final double width;
  final double height;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (width - (width * 0.8)) / 2,
      bottom: (height - (height * 0.7)) / 3,
      child: Container(
        padding: const EdgeInsets.all(15),
        width: width * 0.8,
        height: height * 0.4,
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
                offset: Offset(3, 4))
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
              onPressed: function,
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
    );
  }
}
