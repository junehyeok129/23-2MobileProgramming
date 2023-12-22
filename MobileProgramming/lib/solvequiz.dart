import 'package:flutter/material.dart';

class SolveQuiz extends StatefulWidget {
  @override
  _SolveQuizState createState() => _SolveQuizState();
}

class _SolveQuizState extends State<SolveQuiz> {
  final List<TextEditingController> quizControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  List<Map<String, dynamic>> quizItems = [
    {
      'question': '1번 문제',
      'answer': '2번 문제',
    },
    {
      'question': '21번 문제',
      'answer': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: quizItems.length,
        itemBuilder: (BuildContext context, int i) {
          String question = quizItems[i]['question'];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            // submit logic 구현
          },
          child: Text('Submit'),
        ),
      ),
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
