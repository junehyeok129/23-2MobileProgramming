import 'package:flutter/material.dart';
import 'package:loa/loadrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



// 조찬희 템플릿 제작, 최준혁 통신 및 DB 연결
class SolveQuiz extends StatefulWidget {
  final String quiznum;
  final String subject;
  
  SolveQuiz({required this.quiznum, required this.subject});

  @override
  _SolveQuizState createState() => _SolveQuizState();
}

class _SolveQuizState extends State<SolveQuiz> {
  List<Map<String, dynamic>> quizItems = [];

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/make_quiz'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'subject': widget.subject,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dataList = jsonData['data'] as List<dynamic>;

      print(jsonData['data']);
      print(dataList);
      setState(() {
        quizItems = dataList.map((data) {
          return {
            'id': data['quizid'],
            'user': data['subject'],
            'title': data['question'],
            'content': data['answersheet'],
            'date': data['answer'],
          };
        }).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final List<TextEditingController> quizControllers = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < int.parse(widget.quiznum); i++) {
      quizControllers.add(TextEditingController());
    }

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
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);

            },
          ),
        ],

      ),
      drawer: LoaDrawer(),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: int.parse(widget.quiznum),
        itemBuilder: (BuildContext context, int i) {
          if (i >= quizItems.length) return Container();
          String question = quizItems[i]['title'];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Question ${i + 1}: $question',
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

    for (int i = 1; i < quizItems.length; i++) {
      String enteredAnswer = quizControllers[i].text;
      String correctAnswer = quizItems[i]['content'];

      if (enteredAnswer == correctAnswer) {
        correctAnswers.add('Question ${i + 1}: Correct');
      } else {
        incorrectAnswers.add('Question ${i + 1}: Incorrect');
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
    for (var controller in quizControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
