import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

import 'package:word_composition/screens/menu_screen.dart';
import 'package:word_composition/style/colors.dart';

Future<Object?> WinDialog(BuildContext context, bool isShowConfetti) {
  SMITrigger? confetti;

  void toHome(BuildContext context) {
    confetti!.fire();
    Future.delayed(Duration(milliseconds: 1200), () {
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MenuScreen()));
    });
  }

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

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
              borderRadius: BorderRadius.all(Radius.circular(35))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  // texts
                  Container(
                    height: 270,
                    child: Column(
                      children: [
                        Text(
                          '🎉',
                          style: TextStyle(
                            fontSize: 45,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Победа',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Ееее. Поздравляю. Вы отгадали все слова!',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            toHome(context);
                          },
                          child: Text(
                            "В ГЛАВНОЕ МЕНЮ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 10),
                              shape: StadiumBorder(),
                              shadowColor: AppColors.mainColor),
                        ),
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
                                  scale: 7,
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
