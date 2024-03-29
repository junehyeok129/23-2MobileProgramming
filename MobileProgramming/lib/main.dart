import 'package:flutter/material.dart';
import 'package:loa/QuizInit.dart';
import 'package:loa/initPage.dart';
import 'package:loa/login.dart';
import 'package:loa/listTemplate.dart';
import 'package:loa/noteshareInit.dart';
import 'package:loa/quiz_create.dart';
import 'package:loa/signup.dart';
import 'package:loa/boardTemplate.dart';
import 'package:loa/loadrawer.dart';
import 'package:loa/questionInit.dart';
import 'package:loa/noteshareInit.dart';
import 'package:loa/boardInit.dart';
import 'questionInit.dart';
import 'package:loa/pick.dart';
import 'package:loa/boardTemplate.dart';
import 'solvequiz.dart';


//최준혁 조찬희 제작
void main() {
  runApp(const Loa());
}

class Loa extends StatelessWidget {
  const Loa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Login(),
      routes: {
        '/login' : (context) => Login(),
        '/init' : (context) => InitPage(),
        '/quiz' : (context) => QuizInit(),
        '/question' : (context) => QuestionInit(),
        '/sharenote' : (context) => NoteShareInit(),
        '/board' : (context) => BoardInit(),
        '/pick' : (context) => Pick(),
        //'/content' : (context) => BoardTemplate(boardid: "1",),
        //'/quiz_create': (context)=> quiz_create(),
        //'/solvequiz': (context)=> SolveQuiz()
      },
    );
  }
}
