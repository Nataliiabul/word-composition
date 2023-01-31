import 'package:flutter/material.dart';
import 'package:word_composition/style/colors.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    // data
    const String word = 'музыка';
    List<String> letters = word.split('');

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        // main column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // words
            Container(
              height: 200,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 50,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: letters.length,
                itemBuilder: ((context, index) {
                  return Draggable(
                    feedback: Container(
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
                          letters[index],
                          style: TextStyle(
                              color: AppColors.mainColor, fontSize: 25),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          letters[index],
                          style: TextStyle(
                              color: AppColors.mainColor, fontSize: 25),
                        ),
                      ),
                    ),
                    child: Container(
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
                          letters[index],
                          style: TextStyle(
                              color: AppColors.mainColor, fontSize: 25),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // receive container
            DragTarget(
              builder: ((context, candidateData, rejectedData) => Container(
                    width: double.maxFinite,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: [],
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
            ),

            // check button
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Проверить',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
