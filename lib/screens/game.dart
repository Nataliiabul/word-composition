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
    _word = wordsData.word;
    _letters = wordsData.splitWord;
    _userLetters = wordsData.startUserWord;
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                    child: Container())),
              ),
              const SizedBox(height: 15),

              // check button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
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
