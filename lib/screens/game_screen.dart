import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
// import 'package:rive/rive.dart';

import 'package:word_composition/data.dart';
import 'package:word_composition/screens/menu_screen.dart';
import 'package:word_composition/style/colors.dart';
import 'package:word_composition/widgets/dialogs/show_check_word_dialog.dart';
import 'package:word_composition/widgets/dialogs/show_to_home_dialog.dart';
import 'package:word_composition/widgets/dialogs/show_win_dialog.dart';
import 'package:word_composition/widgets/letter_container.dart';

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

  // late SMITrigger check;
  // late SMITrigger error;
  // late SMITrigger reset;

  // bool isShowLoading = false;

  // StateMachineController getRiveController(Artboard artboard) {
  //   StateMachineController? controller = StateMachineController.fromArtboard(artboard, "State Machine 1");
  //   artboard.addController(controller!);
  //   return controller;
  // }

  initGame() {
    final wordsData = Provider.of<Words>(context, listen: false);
    _letters = wordsData.splitWord;
    _userLetters = wordsData.startUserWord;
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
          // main
          child: Stack(
            children: [
              // main column
              Column(
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
                          onPressed: (){
                            showToHomeDialog(context);
                          },
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
                      return Column(
                        children: [
                          // can drag
                          if (!letterItem.isAccepted)
                            Draggable(
                              data: letterItem,
                              feedback: LetterContainer(
                                letter: letterItem.letter,
                                letterColor: AppColors.secondColor,
                                backgroundColor: AppColors.firstColor,
                              ),
                              childWhenDragging: LetterContainer(
                                letter: letterItem.letter,
                                letterColor: AppColors.secondColor,
                                backgroundColor:
                                    AppColors.firstColor.withOpacity(0.3),
                              ),
                              child: LetterContainer(
                                letter: letterItem.letter,
                                letterColor: AppColors.secondColor,
                                backgroundColor: AppColors.firstColor,
                              ),
                            ),

                          // can not drag
                          if (letterItem.isAccepted)
                            LetterContainer(
                              backgroundColor: AppColors.secondColor,
                              letterColor: AppColors.firstColor,
                              letter: letterItem.letter,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),

                  // receive container
                  DragTarget<LetterItem>(
                    onAccept: (receivedItem) {
                      _isAccepting = false;
                      wordsData.addLetter(receivedItem.letter);

                      setState(() {
                        receivedItem.isAccepted = true;
                      });
                    },
                    onWillAccept: (receivedItem) {
                      _isAccepting = true;

                      return true;
                    },
                    onLeave: (receivedItem) {
                      _isAccepting = false;
                    },
                    builder: ((context, candidateData, rejectedData) =>
                        Container(
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
                                  return LetterContainer(
                                    backgroundColor: Colors.transparent,
                                    letterColor: AppColors.secondColor,
                                    letter: userLetterItem.letter,
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
                          showCheckWordDialog(context, wordsData.checkCorrectAnswer());
                          if (wordsData.checkCorrectAnswer()) {
                            // next word
                            if (wordsData.canUpdateCurrentIndex()) {
                              setState(() {
                                wordsData.updateCurrentIndex();
                                initGame();
                              });
                            } else {
                              // all words are guessed
                              showWinDialog(context);
                            }
                          }
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
              // Positioned.fill(
              //   child: RiveAnimation.asset("assets/animation/check.riv",
              //   onInit: (artboard) {
              //     StateMachineController controller = getRiveController(artboard);
              //     check = controller.findSMI("Check") as SMITrigger;
              //     error = controller.findSMI("Error") as SMITrigger;
              //     reset = controller.findSMI("Reset") as SMITrigger;
              //   },),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
