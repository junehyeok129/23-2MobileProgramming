import 'package:flutter/material.dart';
import 'package:loa/loadrawer.dart';


// 조찬희 템플릿 작성, 최준혁 DB 및 통신 연결
class SolveQuiz extends StatefulWidget {
  @override
  _SolveQuizState createState() => _SolveQuizState();
}

class _SolveQuizState extends State<SolveQuiz> {
  final List<TextEditingController> quizControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<Map<String, dynamic>> quizItems = [
    {
      'question': '1번 문제',
      'answer': '1번 답안',
    },
    {
      'question': '21번 문제',
      'answer': '2번 답안',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    ),),
      drawer: LoaDrawer(),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: quizItems.length,
        itemBuilder: (BuildContext context, int i) {
          String question = quizItems[i]['question'];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                        spreadRadius:5,
                    blurRadius: 7,
                      offset: Offset(0,3)
                  )
                ]
              ),

              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Q$i: $question',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    TextField(
                      controller: quizControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Answer',

                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // submit logic 구현
            checkAnswers();

          },
          child: Text('Submit'),
        ),
      ),
    );
  }

  void checkAnswers() {
    List<String> correctAnswers = [];
    List<String> incorrectAnswers = [];

    for (int i = 0; i < quizItems.length; i++) {
      String enteredAnswer = quizControllers[i].text;
      String correctAnswer = quizItems[i]['answer'];

      if (enteredAnswer == correctAnswer) {
        correctAnswers.add('Q${i + 1}: $correctAnswer');
      } else {
        incorrectAnswers.add('Q${i + 1}: Correct Answer is $correctAnswer');
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Results'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (correctAnswers.isNotEmpty)
                Text('Correct Answers:'),
              for (String correctAnswer in correctAnswers)
                Text(correctAnswer, style: TextStyle(color: Colors.green)),
              if (incorrectAnswers.isNotEmpty)
                Text('Incorrect Answers:'),
              for (String incorrectAnswer in incorrectAnswers)
                Text(incorrectAnswer, style: TextStyle(color: Colors.red)),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    for (var controller in quizControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
