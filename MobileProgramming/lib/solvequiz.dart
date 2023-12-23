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
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              Text('QUIZ'),
              Text('과목명',style: TextStyle(fontSize: 10),)
            ],
          ),
        ),

      ),
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
