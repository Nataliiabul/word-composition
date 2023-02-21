import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:word_composition/data.dart';
import 'package:word_composition/screens/menu_screen.dart';
import 'package:word_composition/style/colors.dart';

Future<Object?> showWinDialog(BuildContext context) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Победа',
            style: TextStyle(
              color: AppColors.secondColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Поздравляем! Вы отгадали все слова!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: AppColors.secondColor,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'В главное меню',
                style: TextStyle(
                  color: AppColors.secondColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MenuScreen()));
                Provider.of<Words>(context, listen: false).clearData();
              },
            ),
          ],
        );
      },
    );
}