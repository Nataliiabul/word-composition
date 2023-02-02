import 'dart:isolate';

import 'package:flutter/cupertino.dart';

class LetterItem {
  final String letter;
  bool isAccepting;

  LetterItem({
    required this.letter,
    this.isAccepting = false,
  });
}

class Words with ChangeNotifier {
  final String word = 'музыка';
  List letters = [];
  List userLetters = [];

  get splitWord {
    for (int i = 0; i < word.length; i++) {
      letters.add(
        LetterItem(letter: word[i]),
      );
    }
    return letters;
  }

  get startUserWord {
    for (int i = 0; i < word.length; i++) {
      userLetters.add(
        LetterItem(letter: '-'),
      );
    }
    return userLetters;
  }
}
