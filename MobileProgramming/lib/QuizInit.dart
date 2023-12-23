import 'package:flutter/material.dart';
import 'package:loa/main.dart';
import 'package:loa/login.dart';
import 'package:loa/quiz_main.dart';
import 'package:loa/signup.dart';
import 'package:loa/loadrawer.dart';
import 'package:loa/makequiz.dart';
import 'package:loa/solvequiz.dart';


class QuizInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Image.asset('assets/images/menulogo.png'),
              );
            },
          ),
          title: Text(
            'Quiz',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  '퀴즈 풀기',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              Tab(
                child: Text(
                  '퀴즈 만들기',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ],
          ),
        ),
        drawer: LoaDrawer(),
        body: TabBarView(
          children: [
            quiz_main(),
            MakeQuiz()
          ],
        ),
      ),
    );
  }
}

