import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:word_composition/screens/menu_screen.dart';

Future<Object?> WinDialog(BuildContext context, bool isShowConfetti) {
  void toHome(BuildContext context) {
    Navigator.pop(context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MenuScreen()));
  }

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  SMITrigger? confetti;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    //
  });

  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'Win',
    context: context,
    pageBuilder: (context, _, __) {
      return Center(
        child: Container(
          height: 300,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.98),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  // texts
                  Container(
                    height: 300,
                    child: Column(
                      children: [
                        Text('Победа'),
                        SizedBox(height: 15),
                        Text(
                          'текст текст текст текст текст',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                            onPressed: () {
                              toHome(context);
                            },
                            child: Text('to home'))
                      ],
                    ),
                  ),

                  isShowConfetti
                      ? Positioned.fill(
                          child: Column(
                            children: [
                              Spacer(flex: 3),
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Transform.scale(
                                  scale: 6,
                                  child: RiveAnimation.asset(
                                    "assets/animation/confetti.riv",
                                    onInit: (artboard) {
                                      StateMachineController controller =
                                          getRiveController(artboard);
                                      confetti = controller.findSMI(
                                          "Trigger explosion") as SMITrigger;
                                    },
                                  ),
                                ),
                              ),
                              Spacer(flex: 1),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
