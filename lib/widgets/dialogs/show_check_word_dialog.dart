import 'package:flutter/material.dart';

Future<Object?> showCheckWordDialog(BuildContext context, bool isCorrect) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              isCorrect ? const Text('Правильно') : const Text('Неправильно'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                isCorrect
                    ? const Text('Вы отгадали слово!')
                    : const Text('Загадано другое слово'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ОК'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
  );
}