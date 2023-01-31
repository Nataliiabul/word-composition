import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_composition/data.dart';
import 'package:word_composition/screens/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Words(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word Composition',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: GameScreen(),
      ),
    );
  }
}
