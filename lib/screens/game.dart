import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:word_composition/data.dart';
import 'package:word_composition/style/colors.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List _letters = [];
  List _userLetters = [];
  String _word = '';
  bool _isAccepting = false;

  initGame() {
    final wordsData = Provider.of<Words>(context, listen: false);
    _word = wordsData.correctWord;
    _letters = wordsData.splitWord;
    _userLetters = wordsData.startUserWord;
    print(_userLetters);
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  // dialog
  Future<void> _showDialog(bool isCorrect) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: isCorrect ? Text('Правильно') : Text('Неправильно'),
        content: SingleChildScrollView(
          child: ListBody(
            children:[
              isCorrect ? Text('Вы отгадали слово!') : Text('Загадано другое слово') ,
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
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: const Text(
          'Word Composition',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
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
              // draggable letters
              Wrap(
                children: _letters.map((letterItem) {
                  return Draggable(
                    data: letterItem,
                    feedback: Container(
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letterItem.letter,
                          style: TextStyle(
                              color: AppColors.mainColor,
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
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letterItem.letter,
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letterItem.letter,
                          style: TextStyle(
                            color: AppColors.mainColor,
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
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.grey,
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
                                decoration: const BoxDecoration(
                                  // color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    userLetterItem.letter,
                                    style: TextStyle(
                                        color: AppColors.mainColor,
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
                    backgroundColor: Colors.grey,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          initGame();
                        });
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        color: Colors.white,
                        size: 40,
                      ),
                      
                    ),
                  ),
                  SizedBox(width: 15),

                  // check
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(wordsData.checkCorrectAnswer());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
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
