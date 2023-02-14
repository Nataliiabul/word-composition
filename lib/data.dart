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
  int currentIndex = 0;
  List words = ['музыка', 'котик'];
  // final String correctWord = 'музыка';
  List letters = [];
  List userLetters = [];

  String correctWord() {
    return words[currentIndex];
  }

  get currentNumberWord {
    return currentIndex+1;
  }

  get countWords {
    return words.length;
  }

  get splitWord {
    letters = [];
    for (int i = 0; i < correctWord().length; i++) {
      letters.add(
        LetterItem(letter: correctWord()[i]),
      );
    }
    letters.shuffle();
    return letters;
  }

  get startUserWord {
    userLetters = [];
    for (int i = 0; i < correctWord().length; i++) {
      userLetters.add(
        LetterItem(letter: '-'),
      );
    }
    return userLetters;
  }

  void updateCurrentIndex() {
    currentIndex += 1;
  }

  bool canUpdateCurrentIndex() {
    if (currentIndex+1 == words.length) {
      return false;
    } else {
      return true;
    }
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
    if (userWord == correctWord()) {
      return true;
    } else {
      return false;
    }
  }

  void clearData() {
    currentIndex = 0;
  }
}
