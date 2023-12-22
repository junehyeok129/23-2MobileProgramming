import 'package:flutter/material.dart';
import 'package:loa/initPage.dart';
import 'package:loa/login.dart';
import 'package:loa/listTemplate.dart';
import 'package:loa/signup.dart';
import 'package:loa/boardTemplate.dart';
import 'package:loa/loadrawer.dart';
import 'package:loa/questionInit.dart';

void main() {
  runApp(const Loa());
}

class Loa extends StatelessWidget {
  const Loa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Login(),
      routes: {
        '/init' : (context) => InitPage(),
        //'/quiz' : (context) => Quiz(),
        '/question' : (context) => QuestionInit(),
        //'sharenote' : (context) => ShareNote(),
        //'/board' : (context) => Board(),
        //'/pick' : (context) => Pick()
      },
    );
  }
}