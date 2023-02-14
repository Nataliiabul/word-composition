import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:word_composition/data.dart';
import 'package:word_composition/screens/menu_screen.dart';
import 'package:word_composition/style/colors.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game';
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List _letters = [];
  List _userLetters = [];
  bool _isAccepting = false;

  initGame() {
    final wordsData = Provider.of<Words>(context, listen: false);
    _letters = wordsData.splitWord;
    _userLetters = wordsData.startUserWord;
    print(_userLetters);
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  // go home
  void goHome() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MenuScreen()));
  }

  // dialog to check word
  Future<void> _showToHomeDialog() async {
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

  // dialog to go home
  Future<void> _showCheckWordDialog(bool isCorrect) async {
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final wordsData = Provider.of<Words>(context);
    _userLetters = wordsData.userLetters;

    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        title: const Text(
          'Word Composition',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.secondColor,
      ),
      body: Container(
        height: height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top,
        width: width,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          // main column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // top row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${wordsData.currentNumberWord.toString()} / ${wordsData.countWords.toString()}",
                    style: TextStyle(
                        color: AppColors.firstColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.firstColor,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: _showToHomeDialog,
                      icon: Icon(
                        Icons.home,
                        color: AppColors.secondColor,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.2),

              // draggable letters
              Wrap(
                children: _letters.map((letterItem) {
                  return Draggable(
                    data: letterItem,
                    feedback: Container(
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.firstColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letterItem.letter,
                          style: TextStyle(
                              color: AppColors.secondColor,
                              fontSize: 25,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.firstColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letterItem.letter,
                          style: TextStyle(
                            color: AppColors.secondColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.firstColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letterItem.letter,
                          style: TextStyle(
                            color: AppColors.secondColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),

              // receive container
              DragTarget<LetterItem>(
                onAccept: (receivedItem) {
                  _isAccepting = false;
                  wordsData.addLetter(receivedItem.letter);
                },
                onWillAccept: (receivedItem) {
                  _isAccepting = true;
                  return true;
                },
                onLeave: (receivedItem) {
                  _isAccepting = false;
                },
                builder: ((context, candidateData, rejectedData) => Container(
                      width: double.maxFinite,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: _isAccepting
                            ? AppColors.mainColor.withOpacity(0.3)
                            : AppColors.mainColor,
                      ),

                      // user letters
                      child: Container(
                        child: FittedBox(
                          child: Row(
                            children: _userLetters.map((userLetterItem) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  // color: AppColors.firstColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    userLetterItem.letter,
                                    style: TextStyle(
                                        color: AppColors.secondColor,
                                        fontSize: 25,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 15),

              // buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // reset
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.firstColor,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          initGame();
                        });
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        color: AppColors.secondColor,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                  // check
                  ElevatedButton(
                    onPressed: () {
                      _showCheckWordDialog(wordsData.checkCorrectAnswer());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.firstColor,
                      foregroundColor: AppColors.secondColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 12,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Проверить',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
