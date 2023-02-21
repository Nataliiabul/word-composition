import 'package:flutter/material.dart';

class LetterContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color letterColor;
  final String letter;
  const LetterContainer({
    super.key,
    required this.backgroundColor,
    required this.letterColor,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
              color: letterColor,
              fontSize: 25,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
