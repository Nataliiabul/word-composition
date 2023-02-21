import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:word_composition/data.dart';
import 'package:word_composition/screens/menu_screen.dart';
import 'package:word_composition/style/colors.dart';

Future<Object?> showToHomeDialog(BuildContext context) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Выйти из игры?',
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
                  'Вы уверены, что хотите выйти? Состояние игры не будет сохранено.',
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
                'Да',
                style: TextStyle(
                  color: AppColors.secondColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MenuScreen()));
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MenuScreen()));
                Provider.of<Words>(context, listen: false).clearData();
              },
            ),
            TextButton(
              child: Text(
                'Нет',
                style: TextStyle(
                  color: AppColors.secondColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}