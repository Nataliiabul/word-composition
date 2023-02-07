import 'package:flutter/cupertino.dart';

class LetterItem {
  String letter;
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

  void addLetter(String letter) {
    int dash = 0;
    int num = 0;
    int index = -1;
    userLetters.forEach((element) {
      if (element.letter == '-') {
        dash += 1;
        if (dash == 1) {
          // first where
          index = num;
        }
      }
      num += 1;
    });

    if (index != -1) {
      userLetters[index].letter = letter;
    }
  }

  String userSplitWord() {
    String splitText = '';
    userLetters.forEach((element) {
      splitText += element.letter;
    });
    return splitText;
  }

  bool checkCorrectAnswer() {
    String userWord = userSplitWord();
    if (userWord == word) {
      return true;
    } else {
      return false;
    }
  }
}
