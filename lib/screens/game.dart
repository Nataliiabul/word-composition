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
  String _word ='';

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
        height: height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
        width: width,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                children: _letters.map((letterItem) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        letterItem.letter,
                        style:
                            TextStyle(color: AppColors.mainColor, fontSize: 25),
                      ),
                    ),
                  );
                }).toList(),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
