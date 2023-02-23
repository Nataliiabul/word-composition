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
          borderRadius: const BorderRadius.all(
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
            const SizedBox(height: 15),
            Text(
              'Вам будет предложено несколько слов для отгадывания. Для начала игры нажмите кнопку "старт". Удачи!)',
              style: TextStyle(
                fontSize: 17,
                color: AppColors.mainColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: function,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 35, vertical: 10),
                  shape: StadiumBorder(),
                  shadowColor: AppColors.mainColor),
              child: const Text(
                "СТАРТ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
